From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AFB5AA9.09906@bjapp7>
Date: Fri, 11 May 2001 11:21:13 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Is this driver right?
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,
	I use a borad running MPC850 and HHL 2.2.14.I writed a parport LCD device driver,and successful intall into kernel(it can be seen in /proc/devceis ).But it didn't work,this drivers is portinged from a pSOS's driver(borad is same).

I have added a new line in mem.c
[...]
	plcd_init();
[...]
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#include <linux/init.h>
#include <linux/config.h>
#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/major.h>
#include <linux/sched.h>
#include <linux/malloc.h>
#include <linux/fcntl.h>
#include <linux/delay.h>
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <asm/system.h>


#include "plcd.h"





#define IMAP_ADDR ((uint)0xfa200000) /*borad's IMMR values*/





#define G_BASE          0x0000    /*base address of Graphics RAM memory*/

#define A_BASE          0x1700    /*base address of Attribute RAM memory*/

#define T_BASE          0x1800    /*base address of Text RAM memory*/

#define CG_BASE         0x1c00    /*base address of CG-RAM memory*/

#define BYTES_PER_ROW   30        /*How many bytes per row on screen*/

                                                                  /*This will be 40 with 6x8 font ,30 with 8x8,for both Text &

                                                                Graphics modes in JM240x128A module. Font selection by FS pin on LCD module:

                                                                FS=High: 6x8 font. FS=Low: 8x8 font.*/




/*define  Port D offset to immr*/
#define PDDAT_OFFSET 0x976
#define PDDIR_OFFSET 0x970
#define PDPAR_OFFSET 0x972

/*default the control lines to lcd are  in output mode*/
#define WRHI plcd->pd_con |= 0x10
#define WRLO plcd->pd_con &= ~0x10

#define RDHI plcd->pd_con |= 0x08
#define RDLO plcd->pd_con &= ~0x08

#define CEHI
#define CELO

#define FSHI plcd->pd_con |= 0x04
#define FSLO plcd->pd_con &= ~0x04

#define CDHI plcd->pd_con |= 0x02
#define CDLO plcd->pd_con &= ~0x02


#define RSTHI plcd->pd_con |= 0x01
#define RSTLO plcd->pd_con &= ~0x01


#define DATAIN  plcd->pd_dir=0x1f00
#define DATAOUT plcd->pd_dir=0x1fff

#define DATA plcd->pd_data

typedef struct parportlcd {

        volatile unsigned short pd_dir;

        volatile unsigned short pd_par;

        unsigned char   RESERVED[2];

        volatile unsigned char pd_con;

        volatile unsigned char pd_data;

}lcd;

static void mydelay(int t)

{

long  j, k, i=0x1234;



    while(t--)

        {

        for (j=0; j<30; j++)

            k = j * i;

     }



}

static unsigned char shift( unsigned char src )
{
        unsigned char des=0;
        register int i;
        for(i = 0;i < 8;i++)
                {
                  des=des<<1;
                  des |= src & 0x01;
                  src=src>>1;
                }
        return des;
}

static int sget(void) /*get LCD display status byte*/
{

int lcd_status;
volatile lcd *plcd;
plcd=(lcd*)(( IMAP_ADDR & 0xffff0000)+PDDIR_OFFSET);
DATAIN;
WRHI;
CDHI;
CELO;
RDLO;
lcd_status = DATA;
RDHI;
CEHI;
DATAOUT;
return (shift(lcd_status));
}



static void cput(int byte)
{
volatile lcd *plcd;
plcd=(lcd*)(( IMAP_ADDR & 0xffff0000)+PDDIR_OFFSET);
CDHI;
RDHI;
DATA=shift(byte);
CELO;
WRLO;
CEHI;
WRHI;
}


int d_get(void)
{
int byte;
volatile lcd *plcd;
plcd=(lcd*)(( IMAP_ADDR & 0xffff0000)+PDDIR_OFFSET);
DATAIN;
WRHI;
CDLO;
CELO;
RDLO;
byte = DATA;
CEHI;
RDHI;
DATAOUT;
return (shift(byte));
}


static void d_put(int byte)
{
volatile lcd *plcd;
plcd=(lcd*)(( IMAP_ADDR & 0xffff0000)+PDDIR_OFFSET);
RDHI;
CDLO;
DATA = shift(byte);
CELO;
WRLO;
CEHI;
WRHI;
}

static void lcd_setpixel(int column,int row)
{
unsigned int addr;
addr = G_BASE + (row * BYTES_PER_ROW)+ (column/8);
d_put(addr & 0xff);
d_put(addr >> 8);
cput(ADPSET);
cput(BITSET|(7-(column%8)));
}
static int lcd_getpixel(int column,int row)
{
unsigned int addr;
addr = G_BASE + (row * BYTES_PER_ROW)+ (column/8);
d_put(addr & 0xff);
d_put(addr >> 8);
cput(ADPSET);
cput(RDUNC);
addr = d_get();
return (addr & (1 << (7-(column%8))));
}


static ssize_t plcd_read(struct file * file,char * buf,size_t length,loff_t *ppos)
{
   return 0;
}

static ssize_t plcd_write(struct file * file,char *buf,size_t length,loff_t *ppos)
{
   int x,y;
   x=(int)buf[0];
   y=(int)buf[1];
   lcd_setpixel(x,y);
}

static ssize_t plcd_open(struct inode * inode,struct file * file)
{
   printk("Now will open lcd device!");
   return 0;
}

static ssize_t plcd_release(struct inode *indoe,struct file * file)
{
   return 0;
}



static struct file_operations plcd_fops={
        NULL,
        plcd_read,
        plcd_write,
        NULL,
        NULL,
        NULL,
        NULL,
        plcd_open,
        plcd_release,
        NULL,
        NULL
};


int plcd_init(void)
{
        int major;
        volatile lcd *plcd;
        plcd=(lcd*)(( IMAP_ADDR & 0xffff0000)+PDDIR_OFFSET);
        RSTHI;
        RSTLO;
        mydelay(10);
        RSTHI;
        CEHI; /*disable chip*/
        RDHI; /*disable reading from LCD*/
        WRHI; /*disable writing to LCD*/
        CDHI; /*command/status mode*/
        FSLO; /* 8x8 font;*/
        DATAOUT;

        major=register_chrdev(99,"PLCD",&plcd_fops);

        if(major>=0)
           printk("Successful install PLCD device!\nMajoe:%d\n&&&&&&&&&&&&&&&&&&&&&&\n",major);
        else
           printk("Can't instal PLCD device\n");
        return 0;

}



+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
