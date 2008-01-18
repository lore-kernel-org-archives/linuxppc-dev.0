Return-Path: <ramkumarj2000@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 704EEDDECE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 23:28:39 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1413300pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 04:28:38 -0800 (PST)
Message-ID: <4f8c3030801180428k51645960sf0e1765f82eae1d8@mail.gmail.com>
Date: Fri, 18 Jan 2008 20:28:37 +0800
From: "Ramkumar J" <ramkumarj2000@gmail.com>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Adding new driver in Linux 2.6 - read fails with -1
In-Reply-To: <35786B99AB3FDC45A821572461791973013565AC@gbrwgceumf01.eu.xerox.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3240_1155974.1200659317881"
References: <4f8c3030801180254l1fed257bpdb6839afcfdf2196@mail.gmail.com>
	<35786B99AB3FDC45A821572461791973013565AC@gbrwgceumf01.eu.xerox.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3240_1155974.1200659317881
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Jan 18, 2008 7:22 PM, Jenkins, Clive <Clive.Jenkins@xerox.com> wrote:

> > From: linuxppc-embedded-bounces+clive.jenkins=xerox.com@ozlabs.org
> > [mailto:linuxppc-embedded-bounces+clive.jenkins=xerox.com@ozlabs.org]
> > On Behalf Of Ramkumar J
> > Sent: 18 January 2008 10:54
> > To: linuxppc-embedded@ozlabs.org
> > Subject: Adding new driver in Linux 2.6 - read fails with -1
> >
> > Hi All,
> >
> > I m using the Linux 2.6(2.6.23-rc2) from Grants for ML-403 and
> > I tried to add a new driver for a hardware based stream.
> > [...] For read, the function doesnt seem calling the drivers read
> > routine and exits with -1. [...]
>
> You are not giving enough information -- better to supply the complete
> code of driver and application, and the complete kernel log, or put
> them on a web/ftp site and supply pointers to them.
>
> When your application calls read(), I cannot see whether you are
> passing a valid file descriptor, whether you have opened the device
> etc.  You say read() returns -1, but you don't give the value of errno
> or the error string corresponding to that value. An easy way to get
> this is to use perror() in your app.
>
> >         /* Wait while empty. */
> >         while (((status=readl( ((volatile unsigned char*)
> remapped_address)
> >  + 8)&3))==0)
>
> One thing I can see is that you have a "busy wait" loop in your
> driver's read method. This will waste CPU time and may hang
> indefinitely. Better to use wait-event_interruptible, and check for
> termination of the wait by unexpected events such as signals and
> changes of power management state.
>
> Clive
>



Hi,

Thanks a lot for replying. I will try using the perror() function and modify
the busy-loop through wait-for functions. Also, the way I have accessed the
memory mapped IO, is to ioremap() the physical address and then use readl()
functions. Is this correct.

Following is the link to the driver file,
http://www.geocities.com/ramkumarj_2000/impulse-stream.c
http://www.geocities.com/ramkumarj_2000/1.txt as impulse-stream.h
This is intermediate layer and part of my application space,
http://www.geocities.com/ramkumarj_2000/co_stream_linux.c

The application is,
http://www.geocities.com/ramkumarj_2000/HelloWorld.c
http://www.geocities.com/ramkumarj_2000/HelloWorld_sw.c

Logs at,
http://www.geocities.com/ramkumarj_2000/logs.txt
http://www.geocities.com/ramkumarj_2000/kernellog.txt

My apologies for the dirty code. To add some background, it starts from the
main() in HelloWorld.c and it proceeds calling the hear_hello() in
HelloWorld_sw.c . The co_stream_* functions are defined in intermediate
layer co_stream_linux.c and co_stream_open is defined to nothing in one
header file. The open and ioctl call ( modified a little in the driver now
for debugging) map from co_stream_attach.
co_stream_read is read and co_stream_write is the write to driver.

Though the logs indicate the call of release function before the read, I m
not quite sure about this as the read not being called have failed to get
inside the kernel messages.

Thanks and Regards,
Ramkumar.

------=_Part_3240_1155974.1200659317881
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div class="gmail_quote">On Jan 18, 2008 7:22 PM, Jenkins, Clive &lt;<a href="mailto:Clive.Jenkins@xerox.com">Clive.Jenkins@xerox.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; From: linuxppc-embedded-bounces+clive.jenkins=<a href="mailto:xerox.com@ozlabs.org">xerox.com@ozlabs.org
</a><br>&gt; [mailto:<a href="mailto:linuxppc-embedded-bounces+clive.jenkins=xerox.com@ozlabs.org">linuxppc-embedded-bounces+clive.jenkins=xerox.com@ozlabs.org</a>]<br>&gt; On Behalf Of Ramkumar J<br>&gt; Sent: 18 January 2008 10:54
<br>&gt; To: <a href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a><br>&gt; Subject: Adding new driver in Linux 2.6 - read fails with -1<br>
<div class="Ih2E3d">&gt;<br>&gt; Hi All,<br>&gt;<br>&gt; I m using the Linux 2.6(2.6.23-rc2) from Grants for ML-403 and<br>&gt; I tried to add a new driver for a hardware based stream.<br></div>&gt; [...] For read, the function doesnt seem calling the drivers read
<br>&gt; routine and exits with -1. [...]<br><br>You are not giving enough information -- better to supply the complete<br>code of driver and application, and the complete kernel log, or put<br>them on a web/ftp site and supply pointers to them.
<br><br>When your application calls read(), I cannot see whether you are<br>passing a valid file descriptor, whether you have opened the device<br>etc. &nbsp;You say read() returns -1, but you don&#39;t give the value of errno
<br>or the error string corresponding to that value. An easy way to get<br>this is to use perror() in your app.<br>
<div class="Ih2E3d"><br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; /* Wait while empty. */<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; while (((status=readl( ((volatile unsigned char*)<br>remapped_address)<br>&gt; &nbsp;+ 8)&amp;3))==0)<br><br></div>One thing I can see is that you have a &quot;busy wait&quot; loop in your
<br>driver&#39;s read method. This will waste CPU time and may hang<br>indefinitely. Better to use wait-event_interruptible, and check for<br>termination of the wait by unexpected events such as signals and<br>changes of power management state.
<br><font color="#888888"><br>Clive<br></font></blockquote></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Hi,</div>
<div>&nbsp;</div>
<div>Thanks a lot for replying. I will try using the perror() function and modify the busy-loop through wait-for functions. Also, the way I have accessed the memory mapped IO, is to ioremap() the physical address and then use readl() functions. Is this correct. 
</div>
<div>&nbsp;</div>
<div>Following is the link to the driver file,</div>
<div><a href="http://www.geocities.com/ramkumarj_2000/impulse-stream.c">http://www.geocities.com/ramkumarj_2000/impulse-stream.c</a></div>
<div><a href="http://www.geocities.com/ramkumarj_2000/1.txt">http://www.geocities.com/ramkumarj_2000/1.txt</a>&nbsp;as impulse-stream.h<br></div>
<div>This is intermediate layer and part of my application space,</div>
<div><a href="http://www.geocities.com/ramkumarj_2000/co_stream_linux.c">http://www.geocities.com/ramkumarj_2000/co_stream_linux.c</a></div>
<div>&nbsp;</div>
<div>The application is,</div>
<div><a href="http://www.geocities.com/ramkumarj_2000/HelloWorld.c">http://www.geocities.com/ramkumarj_2000/HelloWorld.c</a></div>
<div><a href="http://www.geocities.com/ramkumarj_2000/HelloWorld_sw.c">http://www.geocities.com/ramkumarj_2000/HelloWorld_sw.c</a></div>
<div>&nbsp;</div>
<div>Logs at,</div>
<div><a href="http://www.geocities.com/ramkumarj_2000/logs.txt">http://www.geocities.com/ramkumarj_2000/logs.txt</a></div>
<div><a href="http://www.geocities.com/ramkumarj_2000/kernellog.txt">http://www.geocities.com/ramkumarj_2000/kernellog.txt</a></div>
<div>&nbsp;</div>
<div>My apologies for the dirty code. To add some background, it starts from the main() in HelloWorld.c and it proceeds calling the hear_hello() in HelloWorld_sw.c . The co_stream_* functions are defined in intermediate layer co_stream_linux.c and co_stream_open is defined to nothing&nbsp;in one header file. The open and ioctl call ( modified a little in the driver now for debugging) map from co_stream_attach.
</div>
<div>co_stream_read is read and co_stream_write is the write to driver.</div>
<div>&nbsp;</div>
<div>Though the logs indicate the call of release function before the read, I m not quite sure about this as the read not being called have failed to get inside the kernel messages.</div>
<div>&nbsp;</div>
<div>Thanks and Regards,</div>
<div>Ramkumar.</div>

------=_Part_3240_1155974.1200659317881--
