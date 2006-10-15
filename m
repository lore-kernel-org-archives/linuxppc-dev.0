Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C85B267C1D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 07:09:54 +1000 (EST)
Message-ID: <4532A1D1.4040006@dlasys.net>
Date: Sun, 15 Oct 2006 17:02:09 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<452F36AE.6040205@dlasys.net> <8764eovg81.fsf@sleipner.barco.com>
In-Reply-To: <8764eovg81.fsf@sleipner.barco.com>
Content-Type: multipart/alternative;
	boundary="------------070702090903080101010102"
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

This is a multi-part message in MIME format.
--------------070702090903080101010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Korsgaard wrote:
>>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:
>>>>>>             
>
> Hi,
>
> David>    Peter's driver uses the IORESOURCE requests to pull platform
> David> data.  Most other serial platformdevices pull a uart_port
> David> object.  My limited understanding of IORESOURCE is that it is
> David> not sufficiently deep to support the parameters that are needed
> David> to support UartLite such as a DCR flag and a regoffset.
>
> I'm still not convinced that DCR access and variable register offsets
> are needed - But it can always be added (through a seperate struct in
> platform_data) - Patches are welcome.
>   
    It does not matter whether you or I are convinced. It matters 
whether there are people that need it.
    Xilinx has a reference design that uses DCR. While I have never 
tripped over an actual implimentation that uses
    DCR there are others on this list that have.

> The same with interrupt-less support if the changes are not too
> intrusive.
>
>   
    Right now I can not get your driver to work. I spent alot of time 
trying to fix it and got nowhere.
    I can not get it to receive at all, and I can not get it to send 
after switching from the console driver
    without dropping characters. I am very busy with other things right 
now and it is going to be a long
    time before I have time to look at your driver again.

    In the meantime, my own driver works - atleast for me. And it is out 
in the real world on production systems.
 
   The most instrusive changes is likely to be fixing whatever is 
causing yours to drop characters - the problem is
    worse when I patch your driver to be timer driven - but that is 
likely because your service routines blindly presume it is
    safe to transmit - true on a Tx empty interrupt, but  not on a timer 
tick.

    But what matters is not whether the changes are intrusive, but  
whether they produce a better result.









> David>    You are welcome to do that. I already patched his driver to
> David> work with my early console support as well as adding the
> David> boot-bash stuff similar to yours. But I gave up actually using
> David> it when I could not get it to work.
>
> Which is odd as I've gotten positive feedback from others.
>   
    I am glad somebody is using your driver and finding it works. But we 
are all better served by fixing the failure cases.

    It is not particularly odd at all. The UartLite despite its 
simplicity is   worse than a normal driver - different
    FPGA implimentations can vary. Normal drivers for fixed inflexible 
hardware often do not work accross
    differing implimentations, why would you expect something like 
UartLite to be invariant ?

    One of the other reasons for implimenting polling is because a 
polled driver tends to work accross
    wider hardware variations. You can not make state assumptions in a 
poll routine,
    and if the poll routine does nto run then the rest of the OS is hosed.

    Even today, flakey hardware interrupts are not unheard of.

    I would also ask what data rates you and others with Working 
UartLites are using ?
    The cases I am dealing with run at 57600 and 115200 respectively - 
it is not that odd for
    driver problems to manifest themselves only or more frequently at 
high baud rates.


> David>    Next time I get an opportunity I am going to try to setup an
> David> ml403 to atleast verify that Peter's driver is working there.
>
> Great.
>   
    Without being difficult - don't hold your breath. It is something I 
would like to do, but
 I do not have  infinite time.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------070702090903080101010102
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Peter Korsgaard wrote:
<blockquote cite="mid:8764eovg81.fsf@sleipner.barco.com" type="cite">
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">"David" == David H Lynch <a class="moz-txt-link-rfc2396E" href="mailto:dhlii@dlasys.net">&lt;dhlii@dlasys.net&gt;</a> writes:
            </pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
Hi,

David&gt;    Peter's driver uses the IORESOURCE requests to pull platform
David&gt; data.  Most other serial platformdevices pull a uart_port
David&gt; object.  My limited understanding of IORESOURCE is that it is
David&gt; not sufficiently deep to support the parameters that are needed
David&gt; to support UartLite such as a DCR flag and a regoffset.

I'm still not convinced that DCR access and variable register offsets
are needed - But it can always be added (through a seperate struct in
platform_data) - Patches are welcome.
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; It does not matter whether you or I are convinced. It matters
whether there are people that need it.<br>
&nbsp;&nbsp;&nbsp; Xilinx has a reference design that uses DCR. While I have never
tripped over an actual implimentation that uses<br>
&nbsp;&nbsp;&nbsp; DCR there are others on this list that have.<br>
<br>
<blockquote cite="mid:8764eovg81.fsf@sleipner.barco.com" type="cite">
  <pre wrap="">
The same with interrupt-less support if the changes are not too
intrusive.

  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; Right now I can not get your driver to work. I spent alot of time
trying to fix it and got nowhere.<br>
&nbsp;&nbsp;&nbsp; I can not get it to receive at all, and I can not get it to send
after switching from the console driver<br>
&nbsp;&nbsp;&nbsp; without dropping characters. I am very busy with other things right
now and it is going to be a long <br>
&nbsp;&nbsp;&nbsp; time before I have time to look at your driver again.<br>
<br>
&nbsp;&nbsp;&nbsp; In the meantime, my own driver works - atleast for me. And it is
out in the real world on production systems.<br>
&nbsp;<br>
&nbsp;&nbsp; The most instrusive changes is likely to be fixing whatever is
causing yours to drop characters - the problem is <br>
&nbsp;&nbsp;&nbsp; worse when I patch your driver to be timer driven - but that is
likely because your service routines blindly presume it is <br>
&nbsp;&nbsp;&nbsp; safe to transmit - true on a Tx empty interrupt, but&nbsp; not on a
timer tick.<br>
<br>
&nbsp;&nbsp;&nbsp; But what matters is not whether the changes are intrusive, but&nbsp;
whether they produce a better result.<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<blockquote cite="mid:8764eovg81.fsf@sleipner.barco.com" type="cite">
  <pre wrap="">David&gt;    You are welcome to do that. I already patched his driver to
David&gt; work with my early console support as well as adding the
David&gt; boot-bash stuff similar to yours. But I gave up actually using
David&gt; it when I could not get it to work.

Which is odd as I've gotten positive feedback from others.
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; I am glad somebody is using your driver and finding it works. But
we are all better served by fixing the failure cases.<br>
<br>
&nbsp;&nbsp;&nbsp; It is not particularly odd at all. The UartLite despite its
simplicity is &nbsp; worse than a normal driver - different<br>
&nbsp;&nbsp;&nbsp; FPGA implimentations can vary. Normal drivers for fixed inflexible
hardware often do not work accross<br>
&nbsp;&nbsp;&nbsp; differing implimentations, why would you expect something like
UartLite to be invariant ?<br>
<br>
&nbsp;&nbsp;&nbsp; One of the other reasons for implimenting polling is because a
polled driver tends to work accross <br>
&nbsp;&nbsp;&nbsp; wider hardware variations. You can not make state assumptions in a
poll routine, <br>
&nbsp;&nbsp;&nbsp; and if the poll routine does nto run then the rest of the OS is
hosed.<br>
<br>
&nbsp;&nbsp;&nbsp; Even today, flakey hardware interrupts are not unheard of. <br>
<br>
&nbsp;&nbsp;&nbsp; I would also ask what data rates you and others with Working
UartLites are using ?<br>
&nbsp;&nbsp;&nbsp; The cases I am dealing with run at 57600 and 115200 respectively -
it is not that odd for <br>
&nbsp;&nbsp;&nbsp; driver problems to manifest themselves only or more frequently at
high baud rates.<br>
<br>
<br>
<blockquote cite="mid:8764eovg81.fsf@sleipner.barco.com" type="cite">
  <pre wrap="">
David&gt;    Next time I get an opportunity I am going to try to setup an
David&gt; ml403 to atleast verify that Peter's driver is working there.

Great.
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; Without being difficult - don't hold your breath. It is something I
would like to do, but<br>
&nbsp;I do not have&nbsp; infinite time.<br>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------070702090903080101010102--
