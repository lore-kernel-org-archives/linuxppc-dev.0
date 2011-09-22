Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
	[203.91.198.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF96EB6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Sep 2011 01:25:48 +1000 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: I2c driver crash
Date: Thu, 22 Sep 2011 15:25:26 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE012ED4@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <4E57FD3D.6090809@freescale.com>
Content-Type: multipart/alternative;
	boundary="_000_40631E9A2581F14BA60888C87A76A1FE012ED4HYDMKDMBX4wiproco_"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_40631E9A2581F14BA60888C87A76A1FE012ED4HYDMKDMBX4wiproco_
Content-Type: text/plain; charset="us-ascii"
content-transfer-encoding: quoted-printable

Hi Scott,

When I call if  i2c_master_send(&ds75->i2c_client,buffer,2) it crashes. In m=
odule initialization I don't see any errors. Below are kernel messages. Coul=
d you please let me know what may be the reason for this crash.

-----------Logs---------
Loading Temperature Sensor Interface module (temp_if.ko)
ds75_init
DS75_DRIVER : Open
DS75_DRIVER : Device Open Successful!
DS75_DRIVER  : ioctl TEMP_READ cmd 1
 ds75_temp_read calling i2c_master_send
In i2c_master_send enter-------
Unable to handle kernel paging request for data at address 0x00000010
Faulting instruction address: 0xc01b06a4
Oops: Kernel access of bad area, sig: 11 [#1]

Modules linked in: temp_if gpio_if
NIP: C01B06A4 LR: C01B06A0 CTR: C019BC90
REGS: c309bdc0 TRAP: 0300   Not tainted  (2.6.21.7-hrt1-cfs-v22-grsec-WR2.0b=
l_cgl)
MSR: 00009032 <EE,ME,IR,DR>  CR: 44004822  XER: 00000000
DAR: 00000010, DSISR: 20000000
TASK =3D c306f810[145] 'epn412' THREAD: c309a000
GPR00: 00007D00 C309BE70 C306F810 C02A0000 00000001 00000001 00000000 FDFBD0=
A0
GPR08: 003DE8A0 A827A936 00003F78 C02EAE88 00000001 1011C7C0 03EFD000 FFFFFF=
FF
GPR16: 00000001 00000000 007FFC00 37942FA8 1012EAC0 1001E530 37942FB4 000000=
03
GPR24: 37942FB4 00000000 003D0F00 C309BEA8 FFFFFFF7 00000008 C309BEA8 000000=
02
Call Trace:
[C309BE70] [C01B0698]  (unreliable)
[C309BEA0] [C50B71DC]
[C309BED0] [C007A0D0]
[C309BEE0] [C007A158]
[C309BF10] [C007A4EC]
[C309BF40] [C000E780]
--- Exception: c01Instruction dump:
7c0802a6 bf61001c 7c7d1b78 3c60c02a 386313b4 7cbf2b78 90010034 7c9b2378
4be6bc79 386007d0 4be5ac6d 3c60c02a <839d0008> 386313d8 4be6bc61 a01d0004




Below is the driver code.
-------------------------

#include "temp_if.h"
#include <asm-powerpc/uaccess.h>
#include <linux/i2c.h>
//#include <asm/arch/platform.h>


#define I2C_DEBUG

#ifdef      I2C_DEBUG
#define     I2C_DBG1(x)                 printk(KERN_WARNING x)
#define     I2C_DBG2(x,y)               printk(KERN_WARNING x,y)
#define     I2C_DBG3(x,y,z)             printk(KERN_WARNING x,y,z)
#define     I2C_DBG4(w,x,y,z)           printk(KERN_WARNING w,x,y,z)
#else
#define I2C_DBG1(x)
#define I2C_DBG2(x,y)
#define I2C_DBG3(x,y,z)
#define I2C_DBG4(w,x,y,z)
#endif

/* Function Prototype */
static int ds75_open(struct inode *inode, struct file *filp);
static int ds75_iotcl(struct inode *inode, struct file *flip, unsigned int c=
md, unsigned long arg);
static int ds75_release(struct inode *inode, struct file *flip);
int ds75_attach_client(struct ds75_data * ds75, struct i2c_adapter *adapter)=
;

int ds75_attach_adapter(struct i2c_adapter *adapter);
int ds75_detach_client(struct i2c_client *client);




/* Structure */
static struct file_operations tmpsensor_fops =3D
{
        ioctl:          ds75_iotcl,
        open:           ds75_open,
        release:        ds75_release,

};

static struct i2c_driver ds75_driver =3D {
        .driver =3D {
                .name   =3D "DS75",
        },
        .attach_adapter =3D ds75_attach_adapter,
        .detach_client  =3D ds75_detach_client,
};

/* Global Variable */
static int s_nI2CMajor =3D 0;
static int s_bI2CDevOpen =3D 0;
static int s_nUseCnt =3D 0;
struct ds75_data *ds75;


static int ds75_open(struct inode *inode, struct file *flip)
{
  I2C_DBG1( "DS75_DRIVER : Open\n");
  if(s_bI2CDevOpen =3D=3D 0)
    {
      I2C_DBG1("DS75_DRIVER : Device Open Successful!\n");
      s_bI2CDevOpen =3D 1;
      s_nUseCnt++;

    }
  else
    {
      I2C_DBG1("DS75_DRIVER : Device Already Opened Successfully!\n");
      s_bI2CDevOpen =3D 1;
      s_nUseCnt++;
    }
  return 0;
}


static int ds75_release(struct inode *inode, struct file *flip)
{
  I2C_DBG1 (KERN_INFO "Entering ds75_release\n" );
  if(s_bI2CDevOpen)
    {
      if( s_nUseCnt <=3D 0 )
        {
          I2C_DBG1("DS75_DRIVER  : i2c driver can't be released!\n");
          return -EIO;
        }
      else
        {
          I2C_DBG1("DS75_DRIVER  : Release Successful!\n");
          s_nUseCnt--;
          if( s_nUseCnt =3D=3D 0 )
            {
              s_bI2CDevOpen =3D 0;
              I2C_DBG1("DS75_DRIVER  : I2C Driver is Closed!\n");
                }
        }
      return 0;
    }
  else
    {
      I2C_DBG1("DS75_DRIVER  : Release Fail! (Device is Not Open)\n");
      return -EIO;
    }
}

/*
 This function will read the Temperature from the device and copies to user=
 space
*/
static int ds75_temp_read(struct ds75_msg_t *pData)
{
     //unsigned char buffer[4];
     signed char buffer[4];
     int ret;
     buffer[0]=3D0;  /* Writing 0 in to Pointer register. --> Temprature rea=
d register */
     if ((ret =3D i2c_master_send(&ds75->i2c_client,buffer,2)) !=3D2)
     {
         I2C_DBG2("DS75_DRIVER  : Error writing to I2C ret =3D %d\n",ret);
                     return -1;
     }

     /* reading from the temperature read register */
     if (i2c_master_recv(&ds75->i2c_client,buffer,2)!=3D 2)
     {
         I2C_DBG1("DS75_DRIVER  : Error reading from I2C\n");
                     return -1;
     }

     //I2C_DBG3("DS75_DRIVER: data[0] =3D %d, data[1] =3D %d \n",buffer[0],b=
uffer[1]);
        //I2C_DBG3("DS75_DRIVER: data[0] =3D %d, data[1] =3D %d \n",buffer[0=
],buffer[1]);

     /* Copy User Memory Area */
           if(copy_to_user(pData->ReadData,buffer, 2 ) !=3D 0)
           {
              I2C_DBG1("DS75_DRIVER  : error in copying to user space");
              return -1;
           }

     return 0;  /* Success */

}


static int ds75_iotcl(struct inode *inode, struct file *flip, unsigned int c=
md, unsigned long arg)
{
        int nRetVal =3D 0;

        if( ((struct ds75_msg_t *)arg) =3D=3D NULL ){
                I2C_DBG1("DS75_DRIVER  : ioctl Message Buff must not be NULL=
\n");
                return -EFAULT;
        }

        switch(cmd){
                case TEMP_READ:
                        I2C_DBG2("DS75_DRIVER  : ioctl TEMP_READ cmd %d\n",c=
md);
                        nRetVal =3D ds75_temp_read((struct ds75_msg_t *) arg=
);
                        break;

                default:
                        /* Error! */
                        I2C_DBG1("DS75_DRIVER  : Command  not implemented\n"=
);
                        nRetVal =3D -EIO;
                        break;
        }
        return nRetVal;
}


/*
 *  i2c_attach_client - tries to detect and initialize slics
*/
int ds75_attach_client(struct ds75_data * ds75, struct i2c_adapter *adapter)
{
        struct i2c_client * client;

        /* register i2c client */
        client =3D &ds75->i2c_client;
        client->adapter =3D adapter;
        client->driver =3D &ds75_driver;
//      client->flags =3D I2C_CLIENT_ALLOW_USE;
  client->addr =3D DS75_ADDR;
  strlcpy(client->name, "DS75", I2C_NAME_SIZE);
        i2c_set_clientdata(client, ds75);

        if (i2c_attach_client(client))
     return -1;

        printk (KERN_INFO DS75_DRIVER_NAME ": I2C client attached\n");
        return 0;
}

/*
 *  i2c_attach_adapter - initializes the maxim driver
*/
int ds75_attach_adapter(struct i2c_adapter *adapter)
{
        /* allocate maxim_data structure */
        ds75 =3D kmalloc(sizeof (struct ds75_data), GFP_KERNEL);
        if (ds75 =3D=3D NULL)
        {
           printk (KERN_ERR "Unable to allocate memory for ds75 temp sensor=
 driver\n");
           goto err0;
        }
        memset(ds75, 0, sizeof(struct ds75_data));

        /* Attach Spi Client */
        if (ds75_attach_client(ds75, adapter) !=3D 0)
        {
           printk (KERN_ERR "No ds75 device detected\n");
           goto err1;
        }

        return 0;

err1:
        kfree(ds75);
err0:
        return -1;
}

/*
 *  i2c_detach_client - cleans up the maxim driver
*/
int ds75_detach_client(struct i2c_client *client)
{
        struct ds75_data *ds75 =3D i2c_get_clientdata(client);

        if (ds75->owned_irq)
        {
                free_irq(ds75->irq, ds75);
                ds75->owned_irq =3D 0;

        }

        i2c_detach_client(&ds75->i2c_client);

        kfree (ds75);      // Free the kernel memory */

        return 0;
}




/*
 * Temperature sensor DS75 init -
 *
 */
int __init ds75_init(void)
{
        int rc;
        rc =3D i2c_add_driver(&ds75_driver);
        if (rc)
        {
                printk (KERN_ERR DS75_DRIVER_NAME ": unable to add driver\n"=
);
                return rc;
        }

        rc =3D register_chrdev (DS75_DEVICE_MAJOR_NUM, DS75_DRIVER_NAME, &tm=
psensor_fops);
        if (rc)
        {
                printk (KERN_ERR DS75_DRIVER_NAME ": unable to register char=
 device\n");
                return rc;
        }

        return 0;
}

/**
 * maxim _exit -
 *
 *
 */
void __exit ds75_exit(void)
{
        unregister_chrdev (DS75_DEVICE_MAJOR_NUM, DS75_DRIVER_NAME);

        i2c_del_driver(&ds75_driver);
}

MODULE_AUTHOR("xxxx");
MODULE_DESCRIPTION("DS75 I2C driver");
MODULE_LICENSE("GPL");

module_init(ds75_init);
module_exit(ds75_exit);


Regards,
Smitha

Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com

--_000_40631E9A2581F14BA60888C87A76A1FE012ED4HYDMKDMBX4wiproco_
Content-Type: text/html; charset="us-ascii"
content-transfer-encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<title></title>
<meta content=3D"MSHTML 6.00.2900.3698" name=3D"GENERATOR">
</head>
<body>
<!-- Converted from text/plain format -->
<p><font size=3D"2">Hi Scott,<br>
<br>
When I call if&nbsp; i2c_master_send(&amp;ds75-&gt;i2c_client,buffer,2) it c=
rashes. In module initialization I don't see any errors. Below are kernel me=
ssages. Could you please let me know what may be the reason for this crash.<=
br>
<br>
-----------Logs---------<br>
Loading Temperature Sensor Interface module (temp_if.ko)<br>
<font color=3D"#ff0000"><font color=3D"#0000ff">ds75_init<br>
DS75_DRIVER : Open<br>
DS75_DRIVER : Device Open Successful!<br>
DS75_DRIVER&nbsp; : ioctl TEMP_READ cmd 1<br>
&nbsp;ds75_temp_read calling i2c_master_send<br>
In i2c_master_send enter-------<br>
</font>Unable to handle kernel paging request for data at address 0x00000010=
<br>
</font>Faulting instruction address: 0xc01b06a4<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>
<br>
Modules linked in: temp_if gpio_if<br>
NIP: C01B06A4 LR: C01B06A0 CTR: C019BC90<br>
REGS: c309bdc0 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.21.7-hrt1-cfs-v=
22-grsec-WR2.0bl_cgl)<br>
MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 44004822&nbsp; XER: 00000000<br>
DAR: 00000010, DSISR: 20000000<br>
TASK =3D c306f810[145] 'epn412' THREAD: c309a000<br>
GPR00: 00007D00 C309BE70 C306F810 C02A0000 00000001 00000001 00000000 FDFBD0=
A0<br>
GPR08: 003DE8A0 A827A936 00003F78 C02EAE88 00000001 1011C7C0 03EFD000 FFFFFF=
FF<br>
GPR16: 00000001 00000000 007FFC00 37942FA8 1012EAC0 1001E530 37942FB4 000000=
03<br>
GPR24: 37942FB4 00000000 003D0F00 C309BEA8 FFFFFFF7 00000008 C309BEA8 000000=
02<br>
Call Trace:<br>
[C309BE70] [C01B0698]&nbsp; (unreliable)<br>
[C309BEA0] [C50B71DC]<br>
[C309BED0] [C007A0D0]<br>
[C309BEE0] [C007A158]<br>
[C309BF10] [C007A4EC]<br>
[C309BF40] [C000E780]<br>
--- Exception: c01Instruction dump:<br>
7c0802a6 bf61001c 7c7d1b78 3c60c02a 386313b4 7cbf2b78 90010034 7c9b2378<br>
4be6bc79 386007d0 4be5ac6d 3c60c02a &lt;839d0008&gt; 386313d8 4be6bc61 a01d0=
004<br>
<br>
<br>
<br>
<br>
<strong>Below is the driver code.<br>
-------------------------<br>
</strong><br>
#include &quot;temp_if.h&quot;<br>
#include &lt;asm-powerpc/uaccess.h&gt;<br>
#include &lt;linux/i2c.h&gt;<br>
//#include &lt;asm/arch/platform.h&gt;<br>
<br>
<br>
#define I2C_DEBUG<br>
<br>
#ifdef&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_DEBUG<br>
#define&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG1(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_=
WARNING x)<br>
#define&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG2(x,y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_WARNING x,=
y)<br>
#define&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG3(x,y,z)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_WARNING x,y,z)<br>
#define&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG4(w,x,y,z)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_WARNING w,x,y,z)<br>
#else<br>
#define I2C_DBG1(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
#define I2C_DBG2(x,y)<br>
#define I2C_DBG3(x,y,z)<br>
#define I2C_DBG4(w,x,y,z)<br>
#endif<br>
<br>
/* Function Prototype */<br>
static int ds75_open(struct inode *inode, struct file *filp);<br>
static int ds75_iotcl(struct inode *inode, struct file *flip, unsigned int c=
md, unsigned long arg);<br>
static int ds75_release(struct inode *inode, struct file *flip);<br>
int ds75_attach_client(struct ds75_data * ds75, struct i2c_adapter *adapter)=
;<br>
<br>
int ds75_attach_adapter(struct i2c_adapter *adapter);<br>
int ds75_detach_client(struct i2c_client *client);<br>
<br>
<br>
<br>
<br>
/* Structure */<br>
static struct file_operations tmpsensor_fops =3D<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioctl:&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ds75_iotcl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open: &nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ds75_open,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release:&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ds75_release,&nbsp;&nbsp;<br>
<br>
};<br>
<br>
static struct i2c_driver ds75_driver =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; .name&nbsp;&nbsp; =3D &quot;DS75&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .attach_adapter =3D ds75_attach_a=
dapter,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .detach_client&nbsp; =3D ds75_det=
ach_client,<br>
};<br>
<br>
/* Global Variable */<br>
static int s_nI2CMajor =3D 0;<br>
static int s_bI2CDevOpen =3D 0;<br>
static int s_nUseCnt =3D 0;<br>
struct ds75_data *ds75;<br>
<br>
<br>
static int ds75_open(struct inode *inode, struct file *flip)<br>
{<br>
&nbsp; I2C_DBG1( &quot;DS75_DRIVER : Open\n&quot;);<br>
&nbsp; if(s_bI2CDevOpen =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG1(&quot;DS75_DRIVER : Device Open Succ=
essful!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_bI2CDevOpen =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nUseCnt&#43;&#43;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp; else<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG1(&quot;DS75_DRIVER : Device Already O=
pened Successfully!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_bI2CDevOpen =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nUseCnt&#43;&#43;;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp; return 0;<br>
}<br>
<br>
<br>
static int ds75_release(struct inode *inode, struct file *flip)<br>
{<br>
&nbsp; I2C_DBG1 (KERN_INFO &quot;Entering ds75_release\n&quot; );<br>
&nbsp; if(s_bI2CDevOpen)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( s_nUseCnt &lt;=3D 0 )<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; I2C_DBG1(&quot;DS75_DRIVER=
&nbsp; : i2c driver can't be released!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; return -EIO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; I2C_DBG1(&quot;DS75_DRIVER=
&nbsp; : Release Successful!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; s_nUseCnt--;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; if( s_nUseCnt =3D=3D 0 )<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_=
bI2CDevOpen =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2=
C_DBG1(&quot;DS75_DRIVER&nbsp; : I2C Driver is Closed!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp; else<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG1(&quot;DS75_DRIVER&nbsp; : Release Fa=
il! (Device is Not Open)\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;<br>
&nbsp;&nbsp;&nbsp; }<br>
}<br>
<br>
/*<br>
&nbsp;This function will read the Temperature from the device and copies to=
 user space<br>
*/<br>
static int ds75_temp_read(struct ds75_msg_t *pData)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp; //unsigned char buffer[4];<br>
&nbsp;&nbsp;&nbsp;&nbsp; signed char buffer[4];<br>
&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp; buffer[0]=3D0;&nbsp; /* Writing 0 in to Pointer reg=
ister. --&gt; Temprature read register */<br>
&nbsp;&nbsp;&nbsp;&nbsp; if ((ret =3D i2c_master_send(&amp;ds75-&gt;i2c_clie=
nt,buffer,2)) !=3D2)<br>
&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG2(&quot;DS75_DRIVER&=
nbsp; : Error writing to I2C ret =3D %d\n&quot;,ret);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* reading from the temperature read register */<br=
>
&nbsp;&nbsp;&nbsp;&nbsp; if (i2c_master_recv(&amp;ds75-&gt;i2c_client,buffer=
,2)!=3D 2)<br>
&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG1(&quot;DS75_DRIVER&=
nbsp; : Error reading from I2C\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; //I2C_DBG3(&quot;DS75_DRIVER: data[0] =3D %d, data[=
1] =3D %d \n&quot;,buffer[0],buffer[1]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //I2C_DBG3(&quot;DS75_DRIVER: dat=
a[0] =3D %d, data[1] =3D %d \n&quot;,buffer[0],buffer[1]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Copy User Memory Area */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; if(copy_to_user(pDat=
a-&gt;ReadData,buffer, 2 ) !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2=
C_DBG1(&quot;DS75_DRIVER&nbsp; : error in copying to user space&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; return 0;&nbsp; /* Success */<br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
}<br>
<br>
<br>
static int ds75_iotcl(struct inode *inode, struct file *flip, unsigned int c=
md, unsigned long arg)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int nRetVal =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( ((struct ds75_msg_t *)arg) =
=3D=3D NULL ){<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; I2C_DBG1(&quot;DS75_DRIVER&nbsp; : ioctl Message Buff must not be=
 NULL\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return -EFAULT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(cmd){<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; case TEMP_READ:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG2(&quot;DS75_DRI=
VER&nbsp; : ioctl TEMP_READ cmd %d\n&quot;,cmd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nRetVal =3D ds75_temp_r=
ead((struct ds75_msg_t *) arg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Error! */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_DBG1(&quot;DS75_DRI=
VER&nbsp; : Command&nbsp; not implemented\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nRetVal =3D -EIO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return nRetVal;<br>
}<br>
<br>
<br>
/*<br>
&nbsp;*&nbsp; i2c_attach_client - tries to detect and initialize slics<br>
*/<br>
int ds75_attach_client(struct ds75_data * ds75, struct i2c_adapter *adapter)=
<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_client * client;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* register i2c client */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client =3D &amp;ds75-&gt;i2c_clie=
nt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-&gt;adapter =3D adapter;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-&gt;driver =3D &amp;ds75_d=
river;<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-&gt;flags =3D I2C_CLIENT_ALLOW_USE;<=
br>
&nbsp; client-&gt;addr =3D DS75_ADDR;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;<br>
&nbsp; strlcpy(client-&gt;name, &quot;DS75&quot;, I2C_NAME_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_set_clientdata(client, ds75);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i2c_attach_client(client))<br=
>
&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk (KERN_INFO DS75_DRIVER_NAM=
E &quot;: I2C client attached\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
}<br>
<br>
/*<br>
&nbsp;*&nbsp; i2c_attach_adapter - initializes the maxim driver<br>
*/<br>
int ds75_attach_adapter(struct i2c_adapter *adapter)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate maxim_data structure=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ds75 =3D kmalloc(sizeof (struct d=
s75_data), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ds75 =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; printk (KERN_ERR &qu=
ot;Unable to allocate memory for ds75 temp sensor driver\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; goto err0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(ds75, 0, sizeof(struct ds7=
5_data));<br>
<br>
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Attach Spi Client */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ds75_attach_client(ds75, adap=
ter) !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; printk (KERN_ERR &qu=
ot;No ds75 device detected\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; goto err1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
<br>
err1:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ds75);<br>
err0:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
}<br>
<br>
/*<br>
&nbsp;*&nbsp; i2c_detach_client - cleans up the maxim driver<br>
*/<br>
int ds75_detach_client(struct i2c_client *client)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ds75_data *ds75 =3D i2c_ge=
t_clientdata(client);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ds75-&gt;owned_irq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; free_irq(ds75-&gt;irq, ds75);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ds75-&gt;owned_irq =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_detach_client(&amp;ds75-&gt;i=
2c_client);<br>
&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree (ds75);&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; // Free the kernel memory */<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
}<br>
<br>
<br>
<br>
<br>
/*<br>
&nbsp;* Temperature sensor DS75 init -<br>
&nbsp;*<br>
&nbsp;*/<br>
int __init ds75_init(void)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D i2c_add_driver(&amp;ds75_d=
river);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; printk (KERN_ERR DS75_DRIVER_NAME &quot;: unable to add driver\n&q=
uot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return rc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D register_chrdev (DS75_DEVI=
CE_MAJOR_NUM, DS75_DRIVER_NAME, &amp;tmpsensor_fops);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; printk (KERN_ERR DS75_DRIVER_NAME &quot;: unable to register char=
 device\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return rc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
}<br>
<br>
/**<br>
&nbsp;* maxim _exit -<br>
&nbsp;*<br>
&nbsp;*<br>
&nbsp;*/<br>
void __exit ds75_exit(void)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unregister_chrdev (DS75_DEVICE_MA=
JOR_NUM, DS75_DRIVER_NAME);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_del_driver(&amp;ds75_driver);=
<br>
}<br>
<br>
MODULE_AUTHOR(&quot;xxxx&quot;);<br>
MODULE_DESCRIPTION(&quot;DS75 I2C driver&quot;);<br>
MODULE_LICENSE(&quot;GPL&quot;);<br>
<br>
module_init(ds75_init);<br>
module_exit(ds75_exit);<br>
<br>
<br>
Regards,<br>
Smitha</font> </p>
<P><strong><span style=3D'font-size:10.0pt;font-family:=0A=
"Palatino Linotype","serif";color:green'> Please do not print this email unl=
ess it is absolutely necessary. </span></strong><span style=3D'font-family:"=
Arial","sans-serif"'><o:p></o:p></span></p>=0A=
=0A=
=0A=
<p> The information contained in this electronic message and any attachments=
 to this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you are=
 not the intended recipient, you should not disseminate, distribute or copy=
 this e-mail. Please notify the sender immediately and destroy all copies of=
 this message and any attachments. </p>=0A=
=0A=
<p>WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld check this email and any attachments for the presence of viruses. The co=
mpany accepts no liability for any damage caused by any virus transmitted by=
 this email. </p>=0A=
<p>=0A=
www.wipro.com=0A=
</p>
</body>
</html>

--_000_40631E9A2581F14BA60888C87A76A1FE012ED4HYDMKDMBX4wiproco_--
