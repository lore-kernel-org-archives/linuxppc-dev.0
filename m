Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id 86186DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 01:37:42 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2946022rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 08:37:41 -0700 (PDT)
Message-ID: <319b0ac50808270837ofa75as3b47f975ad3ffaa2@mail.gmail.com>
Date: Wed, 27 Aug 2008 17:37:41 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [TTY] driver sriel tty on ppc board
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10424_19886856.1219851461234"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_10424_19886856.1219851461234
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am trying to code a tty serial driver (UART link). The initialization is :
(model LDD 3)

static int __init tiny_tty_init(void)
{
    int i, retval;

    printk("Initialization of ttyS -> \n");
    tiny_tty_driver=alloc_tty_driver(NB_TTY);
    if(!tiny_tty_driver)
        return -ENOMEM;

    /*Initialize the tty driver*/

    tiny_tty_driver->owner =THIS_MODULE;
    tiny_tty_driver->driver_name = "ttyS";
    tiny_tty_driver->name = "ttyS";
    tiny_tty_driver->major = TTY_MAJOR;
    tiny_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
    tiny_tty_driver->subtype = SERIAL_TYPE_NORMAL;
    tiny_tty_driver->flags = TTY_DRIVER_REAL_RAW;
    tiny_tty_driver->init_termios = tty_std_termios;
    tiny_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD
|HUPCL|CLOCAL;

    tty_set_operations(tiny_tty_driver, &serial_ops);
    /*register the tty driver*/
    retval=tty_register_driver(tiny_tty_driver);
    if(retval)
    {
        printk(KERN_ERR "Failed to register tiny tty driver");
        put_tty_driver(tiny_tty_driver);
        return retval;
    }

    for(i=0; i< NB_TTY; ++i)
        tty_register_device(tiny_tty_driver,i,NULL);
    printk("<-Initialization of ttyS \n");
    return retval;
}

module_init(tiny_tty_init);


but I have a kernel panic :

io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Kernel panic - not syncing: Couldn't register /dev/tty0 driver

Can someone help me to trace the failure ?

Thanks

------=_Part_10424_19886856.1219851461234
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>
<br>
I am trying to code a tty serial driver (UART link). The initialization is :<br>
(model LDD 3)<br>
<br>
static int __init tiny_tty_init(void)<br>
{<br>
&nbsp;&nbsp;&nbsp; int i, retval;<br>
<br>
&nbsp;&nbsp;&nbsp; printk(&quot;Initialization of ttyS -&gt; \n&quot;);<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver=alloc_tty_driver(NB_TTY);<br>
&nbsp;&nbsp;&nbsp; if(!tiny_tty_driver)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
<br>
&nbsp;&nbsp;&nbsp; /*Initialize the tty driver*/<br>
<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;owner =THIS_MODULE;<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;driver_name = &quot;ttyS&quot;;<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;name = &quot;ttyS&quot;;<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;major = TTY_MAJOR;<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;type = TTY_DRIVER_TYPE_SERIAL;<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;subtype = SERIAL_TYPE_NORMAL;<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;flags = TTY_DRIVER_REAL_RAW;<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;init_termios = tty_std_termios;<br>
&nbsp;&nbsp;&nbsp; tiny_tty_driver-&gt;init_termios.c_cflag = B9600 | CS8 | CREAD |HUPCL|CLOCAL;<br>
<br>
&nbsp;&nbsp;&nbsp; tty_set_operations(tiny_tty_driver, &amp;serial_ops);<br>
&nbsp;&nbsp;&nbsp; /*register the tty driver*/<br>
&nbsp;&nbsp;&nbsp; retval=tty_register_driver(tiny_tty_driver);<br>
&nbsp;&nbsp;&nbsp; if(retval)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(KERN_ERR &quot;Failed to register tiny tty driver&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; put_tty_driver(tiny_tty_driver);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; for(i=0; i&lt; NB_TTY; ++i)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tty_register_device(tiny_tty_driver,i,NULL);<br>
&nbsp;&nbsp;&nbsp; printk(&quot;&lt;-Initialization of ttyS \n&quot;);<br>
&nbsp;&nbsp;&nbsp; return retval;<br>
}<br>
<br>
module_init(tiny_tty_init);<br>
<br>
<br>
but I have a kernel panic : <br>
<br>
io scheduler noop registered<br>
io scheduler anticipatory registered<br>
io scheduler deadline registered<br>
io scheduler cfq registered (default)<br>
Kernel panic - not syncing: Couldn&#39;t register /dev/tty0 driver<br>
<br>
Can someone help me to trace the failure ?<br>
<br>
Thanks<br>
<br>

------=_Part_10424_19886856.1219851461234--
