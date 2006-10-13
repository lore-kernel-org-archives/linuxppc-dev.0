Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7BE867A5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 16:49:41 +1000 (EST)
Message-ID: <452F36AE.6040205@dlasys.net>
Date: Fri, 13 Oct 2006 02:48:14 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: David Bolcsfoldi <dbolcsfoldi@gmail.com>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
In-Reply-To: <609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------070202020200050206040903"
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
--------------070202020200050206040903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Bolcsfoldi wrote:
> No I did not know that unfortunately, it could have saved me some work.
> You are of course right and I'd much prefer to make changes to your driver
> instead of writing another one.
>   
    I am sorry you put so much effort in. However, you could have 
checked the archives.
    I think there are atleast 3 different UartLite drivers posted since 
January.

    It would be really nice if we could all standardize on one driver.
    But I would not sweat this too much.
    Peter ignored the fact that my driver was posted here in January, 
too and went off and wrote his own
    which does not have early serial port - yours and mine do.
    and does not have polled support - mine does.
    and does not have DCR support - there is another one out there that 
has DCR support.
    and I can not get to work on my hardware - the only Xilinx V4 based 
product that actually defaults to a UartLite
> I've noticed that in the probe function it tries to get some resources
> from the platform_device structure but it looks like that this
> operation will always fail unless I add a 'uartlite' platform device
> or have I completely misunderstood how platform devices work?
>   
    Peter's driver uses the IORESOURCE requests to pull platform data.
    Most other serial platformdevices pull a uart_port object.
    My limited understanding of IORESOURCE is that it is not 
sufficiently deep to support
    the parameters that are needed to support UartLite such as a DCR 
flag and a regoffset.

    Counting yours that is 4.




> But yes, I will try to add support for the things I need to this
> driver instead, most importantly early console support and move the
> #defines for register offsets and such into a separate header file per
> Grants comments
>   
    You are welcome to do that. I already patched his driver to work 
with my early console support as well as adding the boot-bash stuff
    similar to yours. But I gave up actually using it when I could not 
get it to work.

    Next time I get an opportunity I am going to try to setup an ml403 
to atleast verify that Peter's driver is working there.


> Cheers,
> David
>
> On 10/12/06, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>   
>>>>>>> "David" == David Bolcsfoldi <dbolcsfoldi@gmail.com> writes:
>>>>>>>               
>> Hi David,
>>
>> David> here's a set of patches that adds support for Xilinx UART lite
>> David> devices. It has been tested on an ML403-FX using xapp902
>> David> (ml403_ppc_plb_temac) using a 2.6.18 kernel and a BusyBox
>> David> userspace.
>>
>> I guess you didn't know, but there already exists a uartlite driver!
>> It unfortunately didn't made it into 2.6.19-rc1 because Russell
>> stopped maintaining serial stuff, but it's in -mm.
>>
>> It also has an official lanana.org assigned set of device nodes.
>>
>> I didn't look at your patch yet, but I think it would be more useful
>> to add any features missing to my driver than writing yet another
>> driver (I think we're up to 3 now).
>>
>> --
>> Bye, Peter Korsgaard
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>     
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------070202020200050206040903
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
David Bolcsfoldi wrote:
<blockquote
 cite="mid:609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com"
 type="cite">
  <pre wrap="">No I did not know that unfortunately, it could have saved me some work.
You are of course right and I'd much prefer to make changes to your driver
instead of writing another one.
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; I am sorry you put so much effort in. However, you could have
checked the archives.<br>
&nbsp;&nbsp;&nbsp; I think there are atleast 3 different UartLite drivers posted since
January.<br>
<br>
&nbsp;&nbsp;&nbsp; It would be really nice if we could all standardize on one driver.<br>
&nbsp;&nbsp;&nbsp; But I would not sweat this too much.<br>
&nbsp;&nbsp;&nbsp; Peter ignored the fact that my driver was posted here in January,
too and went off and wrote his own<br>
&nbsp;&nbsp;&nbsp; which does not have early serial port - yours and mine do.<br>
&nbsp;&nbsp;&nbsp; and does not have polled support - mine does.<br>
&nbsp;&nbsp;&nbsp; and does not have DCR support - there is another one out there that
has DCR support.<br>
&nbsp;&nbsp;&nbsp; and I can not get to work on my hardware - the only Xilinx V4 based
product that actually defaults to a UartLite<br>
<blockquote
 cite="mid:609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com"
 type="cite">
  <pre wrap="">
I've noticed that in the probe function it tries to get some resources
from the platform_device structure but it looks like that this
operation will always fail unless I add a 'uartlite' platform device
or have I completely misunderstood how platform devices work?
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; Peter's driver uses the IORESOURCE requests to pull platform data.<br>
&nbsp;&nbsp;&nbsp; Most other serial platformdevices pull a uart_port object.<br>
&nbsp;&nbsp;&nbsp; My limited understanding of IORESOURCE is that it is not
sufficiently deep to support <br>
&nbsp;&nbsp;&nbsp; the parameters that are needed to support UartLite such as a DCR
flag and a regoffset.<br>
<br>
&nbsp;&nbsp;&nbsp; Counting yours that is 4.<br>
<br>
<br>
<br>
<br>
<blockquote
 cite="mid:609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com"
 type="cite">
  <pre wrap="">
But yes, I will try to add support for the things I need to this
driver instead, most importantly early console support and move the
#defines for register offsets and such into a separate header file per
Grants comments
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; You are welcome to do that. I already patched his driver to work
with my early console support as well as adding the boot-bash stuff <br>
&nbsp;&nbsp;&nbsp; similar to yours. But I gave up actually using it when I could not
get it to work.<br>
<br>
&nbsp;&nbsp;&nbsp; Next time I get an opportunity I am going to try to setup an ml403
to atleast verify that Peter's driver is working there.<br>
<br>
<br>
<blockquote
 cite="mid:609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com"
 type="cite">
  <pre wrap="">
Cheers,
David

On 10/12/06, Peter Korsgaard <a class="moz-txt-link-rfc2396E" href="mailto:jacmet@sunsite.dk">&lt;jacmet@sunsite.dk&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="">"David" == David Bolcsfoldi <a class="moz-txt-link-rfc2396E" href="mailto:dbolcsfoldi@gmail.com">&lt;dbolcsfoldi@gmail.com&gt;</a> writes:
              </pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <pre wrap="">Hi David,

David&gt; here's a set of patches that adds support for Xilinx UART lite
David&gt; devices. It has been tested on an ML403-FX using xapp902
David&gt; (ml403_ppc_plb_temac) using a 2.6.18 kernel and a BusyBox
David&gt; userspace.

I guess you didn't know, but there already exists a uartlite driver!
It unfortunately didn't made it into 2.6.19-rc1 because Russell
stopped maintaining serial stuff, but it's in -mm.

It also has an official lanana.org assigned set of device nodes.

I didn't look at your patch yet, but I think it would be more useful
to add any features missing to my driver than writing yet another
driver (I think we're up to 3 now).

--
Bye, Peter Korsgaard
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>
  </pre>
</blockquote>
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

--------------070202020200050206040903--
