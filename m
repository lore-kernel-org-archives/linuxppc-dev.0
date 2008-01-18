Return-Path: <ramkumarj2000@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id 76487DDED3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 21:54:12 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so799611nzh.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 02:54:10 -0800 (PST)
Message-ID: <4f8c3030801180254l1fed257bpdb6839afcfdf2196@mail.gmail.com>
Date: Fri, 18 Jan 2008 18:54:09 +0800
From: "Ramkumar J" <ramkumarj2000@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Adding new driver in Linux 2.6 - read fails with -1
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2876_14226228.1200653649616"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2876_14226228.1200653649616
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I m using the Linux 2.6(2.6.23-rc2) from Grants for ML-403 and I tried to
add a new driver for a hardware based stream. When I created the device node
and executed the application, I could see that the printk's in the driver
are getting executed for open, release and ioctl. For read, the function
doesnt seem calling the drivers read routine and exits with -1. However the
same is called when I do a cat < /dev/devnode. Am I missing something ?

--------------------------------------------------------------------------------------------------------------
<Code Snip - Driver>

static struct file_operations co_stream_fops = {
        .owner = THIS_MODULE,
        .open = co_stream_open,
        .read = co_stream_read,
        .write = co_stream_write,
//      .ioctl = co_stream_ioctl,
        .release = co_stream_release
};

static int __init co_stream_init(void)
{
    unsigned int *tmp;
    int i=0;
    dbprintk("Welcome !!!\n");

    if (!request_mem_region(STREAM_PHY_ADDR, STREAM_PHY_SIZE, DRIVER_NAME) )
    {
        printk("Failed to lock the memory...\n");
        goto out;
    }

    if (!(remapped_address = ioremap(STREAM_PHY_ADDR, STREAM_PHY_SIZE)) )
    {
        printk("Failed to remap...\n");
        goto out;
    }

    printk("Address remapped to 0x%08X.\n", remapped_address);

    Major = register_chrdev( 0, DEVICE_NAME, &co_stream_fops);    <=========
Registered fops

    if (Major < 0)
    {
        printk("Registration of the device failed.\n\n");
        goto out;
    }

}


static ssize_t co_stream_read(struct file *filp, char __user *buf, size_t
size, loff_t *l)
{
        printk("\n co_stream_read() is called.\n");
        int data,status;

        /* Wait while empty. */
        while (((status=readl( ((volatile unsigned char*) remapped_address)
+ 8)&3))==0)
...
--------------------------------------------------------------------------------------------------------------
<Code Snip - Application>


    printf("CPU listening for hello...\n\r");
    for ( i = 0; i < 10; i++ ) {
        cstream_read(hello_in, &hi, sizeof(int));
        printf("FPGA hardware says: %d\n\r", hi);
    }

int cstream_read(cstream stream, void *buffer, int size)

{
  int nbytes;
  /* TO ADD : Error handing calls here */

  printf("Value of stream = 0x%08X, stream->fd = %d. \n",
                                        stream, stream->fd);

  printf("Value of buffer = 0x%08X, size = %d. \n", buffer, size );

  if (stream) {
      nbytes = read(stream->fd, buffer, size);
      printf("read bytes from hardware = %d.\n", nbytes);
  }
  else
      printf("stream is NULL here.\n");

  return(0);
}

--------------------------------------------------------------------------------------------------------------
<From System.map>

c00de4d0 t sysrq_handle_reboot
c00de4fc T handle_sysrq
c00de524 t co_stream_write
c00de550 t co_stream_release
c00de598 t co_stream_open
c00de624 t co_stream_read
c00de760 t __uart_start

----------------------------------------
<From console output fops dump>

[    0.383898] Welcome !!!
[    0.384445] Address remapped to 0xC5000000.
[    0.384628]
[    0.384653]
[    0.384675]  Impulse Costream assigned with Major = 254.
[    0.384743] Memory dump of fops structure.
[    0.384803] Address : 0xC01CA350, 0x00000000.
[    0.384867] Address : 0xC01CA354, 0x00000000.
[    0.384932] Address : 0xC01CA358, 0xC00DE624.
[    0.384996] Address : 0xC01CA35C, 0xC00DE524.
[    0.385060] Address : 0xC01CA360, 0x00000000.
[    0.385122] Address : 0xC01CA364, 0x00000000.
[    0.385185] Address : 0xC01CA368, 0x00000000.
[    0.385248] Address : 0xC01CA36C, 0x00000000.
[    0.385311] Address : 0xC01CA370, 0x00000000.
[    0.385374] Address : 0xC01CA374, 0x00000000.
[    0.385437] Address : 0xC01CA378, 0x00000000.
[    0.385499] Address : 0xC01CA37C, 0x00000000.
[    0.385565] Address : 0xC01CA380, 0xC00DE598.
[    0.385627] Address : 0xC01CA384, 0x00000000.
[    0.385693] Address : 0xC01CA388, 0xC00DE550.
[    0.385756] Address : 0xC01CA38C, 0x00000000.
[    0.385818] Address : 0xC01CA390, 0x00000000.
[    0.385881] Address : 0xC01CA394, 0x00000000.
[    0.385944] Address : 0xC01CA398, 0x00000000.
[    0.386007] Address : 0xC01CA39C, 0x00000000.
[    0.386070] Address : 0xC01CA3A0, 0x00000000.
[    0.386133] Address : 0xC01CA3A4, 0x00000000.
[    0.386196] Address : 0xC01CA3A8, 0x00000000.
[    0.386259] Address : 0xC01CA3AC, 0x00000000.
Any help or pointers would be helpful.

Thanks and Regards,
Ramkumar.

------=_Part_2876_14226228.1200653649616
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<p><br>Hi All,</p>
<p>I m using the Linux 2.6(2.6.23-rc2) from Grants for ML-403 and I tried to add a new driver for a hardware based stream. When I created the device node and executed the application, I could see that the printk&#39;s in the driver are getting executed for open, release and ioctl. For read, the function doesnt seem calling the drivers read routine and exits with -1. However the same is called when I do a cat &lt; /dev/devnode. Am I missing something ? 
</p>
<p>--------------------------------------------------------------------------------------------------------------<br>&lt;Code Snip - Driver&gt;</p>
<p>static struct file_operations co_stream_fops = {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner = THIS_MODULE,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .open = co_stream_open,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read = co_stream_read,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write = co_stream_write,<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ioctl = co_stream_ioctl,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release = co_stream_release<br>};</p>
<p>static int __init co_stream_init(void)<br>{<br>&nbsp;&nbsp;&nbsp; unsigned int *tmp;<br>&nbsp;&nbsp;&nbsp; int i=0;<br>&nbsp;&nbsp;&nbsp; dbprintk(&quot;Welcome !!!\n&quot;);</p>
<p>&nbsp;&nbsp;&nbsp; if (!request_mem_region(STREAM_PHY_ADDR, STREAM_PHY_SIZE, DRIVER_NAME) )<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;Failed to lock the memory...\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp; if (!(remapped_address = ioremap(STREAM_PHY_ADDR, STREAM_PHY_SIZE)) )<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;Failed to remap...\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp; printk(&quot;Address remapped to 0x%08X.\n&quot;, remapped_address);</p>
<p>&nbsp;&nbsp;&nbsp; Major = register_chrdev( 0, DEVICE_NAME, &amp;co_stream_fops);&nbsp;&nbsp;&nbsp;&nbsp;&lt;========= Registered fops</p>
<p>&nbsp;&nbsp;&nbsp; if (Major &lt; 0)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;Registration of the device failed.\n\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>&nbsp;&nbsp;&nbsp; }</p>
<p>}</p>
<p><br>static ssize_t co_stream_read(struct file *filp, char __user *buf, size_t size, loff_t *l)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;\n co_stream_read() is called.\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data,status;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait while empty. */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (((status=readl( ((volatile unsigned char*) remapped_address) + 8)&amp;3))==0)<br>...<br>--------------------------------------------------------------------------------------------------------------
<br>&lt;Code Snip - Application&gt;</p>
<p><br>&nbsp;&nbsp;&nbsp; printf(&quot;CPU listening for hello...\n\r&quot;);<br>&nbsp;&nbsp;&nbsp; for ( i = 0; i &lt; 10; i++ ) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cstream_read(hello_in, &amp;hi, sizeof(int));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;FPGA hardware says: %d\n\r&quot;, hi);
<br>&nbsp;&nbsp;&nbsp; }</p>
<p>int cstream_read(cstream stream, void *buffer, int size)</p>
<p>{<br>&nbsp; int nbytes;<br>&nbsp; /* TO ADD : Error handing calls here */</p>
<p>&nbsp; printf(&quot;Value of stream = 0x%08X, stream-&gt;fd = %d. \n&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream, stream-&gt;fd);</p>
<p>&nbsp; printf(&quot;Value of buffer = 0x%08X, size = %d. \n&quot;, buffer, size );</p>
<p>&nbsp; if (stream) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nbytes = read(stream-&gt;fd, buffer, size);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;read bytes from hardware = %d.\n&quot;, nbytes);<br>&nbsp; }<br>&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;stream is NULL here.\n&quot;);</p>
<p>&nbsp; return(0);<br>}</p>
<p>--------------------------------------------------------------------------------------------------------------<br>&lt;From System.map&gt;</p>
<p>c00de4d0 t sysrq_handle_reboot<br>c00de4fc T handle_sysrq<br>c00de524 t co_stream_write<br>c00de550 t co_stream_release<br>c00de598 t co_stream_open<br>c00de624 t co_stream_read<br>c00de760 t __uart_start</p>
<p>----------------------------------------<br>&lt;From console output fops dump&gt;</p>
<p>[&nbsp;&nbsp;&nbsp; 0.383898] Welcome !!!<br>[&nbsp;&nbsp;&nbsp; 0.384445] Address remapped to 0xC5000000.<br>[&nbsp;&nbsp;&nbsp; 0.384628]<br>[&nbsp;&nbsp;&nbsp; 0.384653]<br>[&nbsp;&nbsp;&nbsp; 0.384675]&nbsp; Impulse Costream assigned with Major = 254.<br>[&nbsp;&nbsp;&nbsp; 0.384743] Memory dump of fops structure.
<br>[&nbsp;&nbsp;&nbsp; 0.384803] Address : 0xC01CA350, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.384867] Address : 0xC01CA354, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.384932] Address : 0xC01CA358, 0xC00DE624.<br>[&nbsp;&nbsp;&nbsp; 0.384996] Address : 0xC01CA35C, 0xC00DE524.<br>[&nbsp;&nbsp;&nbsp; 0.385060
] Address : 0xC01CA360, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385122] Address : 0xC01CA364, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385185] Address : 0xC01CA368, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385248] Address : 0xC01CA36C, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385311] Address : 0xC01CA370, 0x00000000.
<br>[&nbsp;&nbsp;&nbsp; 0.385374] Address : 0xC01CA374, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385437] Address : 0xC01CA378, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385499] Address : 0xC01CA37C, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385565] Address : 0xC01CA380, 0xC00DE598.<br>[&nbsp;&nbsp;&nbsp; 0.385627
] Address : 0xC01CA384, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385693] Address : 0xC01CA388, 0xC00DE550.<br>[&nbsp;&nbsp;&nbsp; 0.385756] Address : 0xC01CA38C, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385818] Address : 0xC01CA390, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.385881] Address : 0xC01CA394, 0x00000000.
<br>[&nbsp;&nbsp;&nbsp; 0.385944] Address : 0xC01CA398, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.386007] Address : 0xC01CA39C, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.386070] Address : 0xC01CA3A0, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.386133] Address : 0xC01CA3A4, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.386196
] Address : 0xC01CA3A8, 0x00000000.<br>[&nbsp;&nbsp;&nbsp; 0.386259] Address : 0xC01CA3AC, 0x00000000.</p>
<div>Any help or pointers would be helpful. </div>
<div><br>Thanks and Regards,<br>Ramkumar.</div>
<p><br>&nbsp;</p>

------=_Part_2876_14226228.1200653649616--
