Message-ID: <3CD8E84F.3010600@esd-electronics.com>
Date: Wed, 08 May 2002 10:56:47 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: unexpected bahavior with module - relocation problem ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I got a little problem that I cannot really understand.
I wrote a little device driver for a 405 PPC board. The driver registers a miscdevice.

Normally all misc devices are listed under /proc/misc.
My first attempt resulted in a /proc/misc looking like this:

# cat /proc/misc
187          <- "test" is missing here !
185 gpio

The code is attached. When I change the init stuff for the miscdevice structure
a little bit (see below with WORKING defined), I got the expected bahavior.

Is this a relocation problem when loading the module ? In the two version the NAME string
sits in different segments. Is there a way to fix the problem by a compiler switch ? Is this a PPC issue ?
I noticed that the Linux rtc driver uses the same code as I do, but it does not have the problem.
The difference is that my code is a lkm and mot compiled into the kernel.

Matthias

...

#define NAME   "test"
#define MINOR  187

#ifdef WORKING
static char name[]=NAME;
#endif

static struct file_operations my_fops =
{
...
};

static struct miscdevice my_miscdev =
{
#ifdef WORKING
   name:  name, // results in correct bahavior
#else
   name:  NAME, // results in missing module name in /proc/misc
#endif
   minor: MINOR,
   fops:  &my_fops
};

int __init my_init(void)
{
   misc_register(&my_miscdev);
   return 0;
}


void __exit my_exit(void)
{
   misc_deregister(&my_miscdev);
}

module_init(my_init);
module_exit(my_exit);


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
