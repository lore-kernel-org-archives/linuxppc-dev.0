Return-Path: <scotto2hot-green@yahoo.com>
Received: from web33315.mail.mud.yahoo.com (web33315.mail.mud.yahoo.com
	[68.142.206.130]) by ozlabs.org (Postfix) with SMTP id B46A667B59
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 05:54:02 +1000 (EST)
Message-ID: <20060728195401.35393.qmail@web33315.mail.mud.yahoo.com>
Date: Fri, 28 Jul 2006 12:54:01 -0700 (PDT)
From: scott <scotto2hot-green@yahoo.com>
Subject: Re: using /dev/mem to talk to peripherals on VIIP system
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <7348068C-0799-4FE1-A149-DE8043ABB81E@embeddedalley.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-449117581-1154116441=:35184"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-449117581-1154116441=:35184
Content-Type: text/plain; charset=us-ascii

Hi Dan, thanks for your quick response!  I was using a reference to mmap from this page:
http://www.opengroup.org/onlinepubs/000095399/functions/mmap.html
which states that mmap will return MAP_FAILED if there is an error and the error will be located in errno.    please correct me if this is wrong.  As such i don't believe that the map is failing.

i did in any case make the size modulo with PAGE_SIZE (=4096) as found in asm-ppc/page.h which unfortunately did not fix the problem.  just for the heck of it I also tried every size from 1 up to 65536...

It's worth noting that I also tried treating /dev/mem as a file (as it was intended) by using functions lseek, read, and write.  read and write returned a value of zero upon completion, indicating that no bytes were read/written.  I get the feeling that file I/O functions failing on /dev/mem indicates something important, but I'm not sure what. especially since /dev/mem operations DO work on other parts of physical memory (such as RAM).

--scott

----- Original Message ----
From: Dan Malek <dan@embeddedalley.com>
To: scott <scotto2hot-green@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Sent: Friday, July 28, 2006 11:51:03 AM
Subject: Re: using /dev/mem to talk to peripherals on VIIP system


On Jul 28, 2006, at 1:35 PM, scott wrote:

>   ptr = MAP_FAILED; // Initialize to bad value
>   ptr = (int *) mmap(0, 256, PROT_READ|PROT_WRITE, MAP_SHARED, fd,  
> USER_LOGIC_BASEADDR);

Well, this isn't going to detect an error, since the error code
is returned instead of an address.

>
>   if(ptr==MAP_FAILED) {

    if ((int)ptr == -1) {
>     printf("Err: cannot access address!\n");
>     return -1;
>   }
>

> ....  Any other thoughts?

Your mmap is failing because the size is not modulo PAGE_SIZE.


    -- Dan






--0-449117581-1154116441=:35184
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">Hi Dan, thanks for your quick response!&nbsp; I was using a reference to mmap from this page:<br><span><a target="_blank" href="http://www.opengroup.org/onlinepubs/000095399/functions/mmap.html">http://www.opengroup.org/onlinepubs/000095399/functions/mmap.html</a></span><br>which states that mmap will return MAP_FAILED if there is an error and the error will be located in errno.&nbsp;&nbsp;  please correct me if this is wrong.&nbsp; As such i don't believe that the map is failing.<br><br>i did in any case make the size modulo with PAGE_SIZE (=4096) as found in asm-ppc/page.h which unfortunately did not fix the problem.&nbsp; just for the heck of it I also tried every size from 1 up to 65536...<br><br>It's worth noting that I also tried
 treating /dev/mem as a file (as it was intended) by using functions lseek, read, and write.&nbsp; read and write returned a value of zero upon completion, indicating that no bytes were read/written.&nbsp; I get the feeling that file I/O functions failing on /dev/mem indicates something important, but I'm not sure what. especially since /dev/mem operations DO work on other parts of physical memory (such as RAM).<br><br>--scott<br><br><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">----- Original Message ----<br>From: Dan Malek &lt;dan@embeddedalley.com&gt;<br>To: scott &lt;scotto2hot-green@yahoo.com&gt;<br>Cc: linuxppc-embedded@ozlabs.org<br>Sent: Friday, July 28, 2006 11:51:03 AM<br>Subject: Re: using /dev/mem to talk to peripherals on VIIP system<br><br><div><br>On Jul 28, 2006, at 1:35 PM, scott wrote:<br><br>&gt;&nbsp;&nbsp; ptr = MAP_FAILED; // Initialize to bad value<br>&gt;&nbsp;&nbsp; ptr = (int *) mmap(0, 256, PROT_READ|PROT_WRITE,
 MAP_SHARED, fd,&nbsp;&nbsp;<br>&gt; USER_LOGIC_BASEADDR);<br><br>Well, this isn't going to detect an error, since the error code<br>is returned instead of an address.<br><br>&gt;<br>&gt;&nbsp;&nbsp; if(ptr==MAP_FAILED) {<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if ((int)ptr == -1) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; printf("Err: cannot access address!\n");<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>&gt;&nbsp;&nbsp; }<br>&gt;<br><br>&gt; ....&nbsp;&nbsp;Any other thoughts?<br><br>Your mmap is failing because the size is not modulo PAGE_SIZE.<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;-- Dan<br><br></div></div><br></div></div></body></html>
--0-449117581-1154116441=:35184--
