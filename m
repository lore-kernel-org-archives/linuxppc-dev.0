Message-ID: <01C1938C.BE523E50.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem w/driver writing to User Space
Date: Wed, 2 Jan 2002 12:55:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have written a test driver which, via ioctl() calls
from the app, toggles an LED attached to a PLX PCI
Bridge chip on an mpc860-based board.  The physical addr
of the PLX chip is 0x2000.0000.  The LED, though,
does not respond.

If I temporarily (just as a test) comment-out the
set_fs(USER_DS) call in start_thread(), then the LED is
toggled properly.  So the mechanism for the app controlling
the LED via the driver is in place.

I am obviously having some Kernel-to-User Space problem.

I use ioremap(0x2000.0000,0x4000), called in chr_dev_init() just
prior to calling execve("/sbin/init") to start up the app, to get a
virtual ptr for the driver to use to access the PLX chip, and thus
the LED. The virtual ptr returned is 0xc400.0000.  This ioremap()
call is made long after the kernel VM init.

In response to ioctl() calls from the app, the driver uses put_user()
and get_user() to write and read from the PLX chip using the
virtual ptr returned from ioremap(), which is what they were
designed to do.

I would very much appreciate someone scanning thru the following
code sequence (modified for readability) to see what is out of place.




init()
  do_basic_setup()
     device_setup()
        chr_dev_init()
           led_init()			//Register the LED driver.
  (then execve("/sbin/init");)  	//Get app going.




In driver file led.c, located in /drivers/char:


UINT_8* plxPtr;	   		//Virtual ptr to PLX chip base addr.

//The LED driver file operations structure.
static struct file_operations  led_fops =
  {
  NULL,                         //lseek
  NULL,                         //read
  NULL,                         //write
  NULL,                         //readdir
  NULL,                         //poll
  led_ioctl,                     //ioctl
  NULL,	                        //mmap
  led_open,                   //open
  NULL,	                       //flush
  NULL,	                       //release
  };




INT_32  led_init(void)
{
  register_chrdev(LED_MAJOR,"led",&led_fops);	//MAJOR = 240.
  plxPtr = ioremap((UINT_32) 0x20000000,0x4000);
  return(0);
}




static int led_open(struct inode* inode,
                           struct file*     file)
{
  //Verify the virtual ptr returned from ioremap().
  printk("led_open(): plxPtr = %08x\n",(UINT_32) plxPtr);
  return(0);
}




static INT_32  led_ioctl(struct inode* inode,
                                  struct file*     file,
                                  UINT_32       cmd,
                                  ULONG_32   arg)
{
  switch (cmd)
    {
    case LED_ON:

       plxUser0Write(0);           //Turn LED ON.
       break;

    case LED_OFF:

       plxUser0Write(1);          //Turn LED OFF.
       break;
    }

  return(0);
}




//Turn LED ON or OFF.
void  plxUser0Write(UINT_8 ledState)
{
  UINT_32  regVal;


  get_user(regVal,(UINT_32*) (plxPtr + PCI9054_EEPROM_CTRL_STAT));

  if (ledState == 0)
    put_user(regVal & ~(1 << 16),(UINT_32*) (plxPtr +
PCI9054_EEPROM_CTRL_STAT));
  else
    put_user(regVal | (1 << 16),(UINT_32*) (plxPtr +
PCI9054_EEPROM_CTRL_STAT));
}



Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
