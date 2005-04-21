Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 4CEAF67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 03:32:02 +1000 (EST)
Message-ID: <4267E391.5040006@ru.mvista.com>
Date: Thu, 21 Apr 2005 21:32:01 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85936A@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B85936A@ismail.innsys.innovsys.com>
Content-Type: multipart/alternative;
	boundary="------------090400050106090004050500"
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to
 thestock linux-2.5 (updated)
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
--------------090400050106090004050500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rune Torgersen wrote:

>	From: Vitaly Bordug [mailto:vbordug@ru.mvista.com] 
>	Sent: Thursday, April 21, 2005 10:29
>
>  
>
>>	This is all right. The only thing I still don't understand - 
>>how this stuff work without PCI IRQ (don't know much about 8266
>>    
>>
>though). 
>  
>
>>On my 8272 only one IRQ is produced and it should be demux'ed in order 
>>for PCI devices to work. I agree that the siumcr stuff would better
>>    
>>
>reside 
>  
>
>>in the firmware, and I have submitted related patch to the u-boot-users
>>    
>>
>
>  
>
>>list, but I have no idea whether it would be accepted or not
>>    
>>
>(Wolfgang?).
>
>Ah.. That. I have that in a board specific file. Looks excactly like the
>implementation you have (for the 8266 port) For our internal board, it
>is quite different, so it should probably be in a board specific file
>(eg platforms/board_pci_setup.h)
>	
>  
>
>>	The main point I actually dislike in the current m8260
>>    
>>
>implementation 
>  
>
>>is that it adds defines for the PCI memory map while it exists 
>>(and already included) in platforms/pq2ads.h. The memory maps are 
>>nearly the same so we should decide which one will remain.	
>>    
>>
>
>I think I like the _LOWER/_UPPER/OFFSET variant. And it need to be
>possible to override it in board-files.
>I'll work in getting the 8266 PCI support I have to be integrated into
>the PQ2[F]ADS board support.
>	
>  
>
Great. Than I'll replace PCI_MSTR_* with _LOWER/_UPPER/OFFSET stuff in 
the board-specific file so that it override m8260_pci.h defines.  
Another issue - I want to keep the setup of the second outbound PCI 
window (pcimask1/pcibr1) - since continuous mem/mmio/io is not flexible 
enough - and to keep potarx/pobarx/pocmrx assignments as they are in 
pq_... version (changing of course all relative constants to _LOWER/... 
stuff).

Maybe the m8260.[c,h] should be renamed since this suites not only 826x 
series?

Comments/objections? 

-- 
Sincerely, 
Vitaly


--------------090400050106090004050500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Rune Torgersen wrote:
<blockquote
 cite="midDCEAAC0833DD314AB0B58112AD99B93B85936A@ismail.innsys.innovsys.com"
 type="cite">
  <pre wrap="">	From: Vitaly Bordug [<a class="moz-txt-link-freetext" href="mailto:vbordug@ru.mvista.com">mailto:vbordug@ru.mvista.com</a>] 
	Sent: Thursday, April 21, 2005 10:29

  </pre>
  <blockquote type="cite">
    <pre wrap="">	This is all right. The only thing I still don't understand - 
how this stuff work without PCI IRQ (don't know much about 8266
    </pre>
  </blockquote>
  <pre wrap=""><!---->though). 
  </pre>
  <blockquote type="cite">
    <pre wrap="">On my 8272 only one IRQ is produced and it should be demux'ed in order 
for PCI devices to work. I agree that the siumcr stuff would better
    </pre>
  </blockquote>
  <pre wrap=""><!---->reside 
  </pre>
  <blockquote type="cite">
    <pre wrap="">in the firmware, and I have submitted related patch to the u-boot-users
    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
  <blockquote type="cite">
    <pre wrap="">list, but I have no idea whether it would be accepted or not
    </pre>
  </blockquote>
  <pre wrap=""><!---->(Wolfgang?).

Ah.. That. I have that in a board specific file. Looks excactly like the
implementation you have (for the 8266 port) For our internal board, it
is quite different, so it should probably be in a board specific file
(eg platforms/board_pci_setup.h)
	
  </pre>
  <blockquote type="cite">
    <pre wrap="">	The main point I actually dislike in the current m8260
    </pre>
  </blockquote>
  <pre wrap=""><!---->implementation 
  </pre>
  <blockquote type="cite">
    <pre wrap="">is that it adds defines for the PCI memory map while it exists 
(and already included) in platforms/pq2ads.h. The memory maps are 
nearly the same so we should decide which one will remain.	
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I think I like the _LOWER/_UPPER/OFFSET variant. And it need to be
possible to override it in board-files.
I'll work in getting the 8266 PCI support I have to be integrated into
the PQ2[F]ADS board support.
	
  </pre>
</blockquote>
Great. Than I'll replace PCI_MSTR_* with _LOWER/_UPPER/OFFSET stuff in
the board-specific file so that it override m8260_pci.h defines.&nbsp;
Another issue - I want to keep the setup of
the second outbound PCI window (pcimask1/pcibr1) - since continuous
mem/mmio/io is not flexible enough - and to keep potarx/pobarx/pocmrx
assignments as they are in pq_... version (changing of course all
relative
constants to _LOWER/... stuff). <br>
<br>
Maybe the m8260.[c,h] should be renamed since this suites not only 826x
series?<br>
<pre wrap="">Comments/objections? 
</pre>
<pre class="moz-signature" cols="72">
</pre>
<pre class="moz-signature" cols="72">-- 
Sincerely, 
Vitaly
</pre>
</body>
</html>

--------------090400050106090004050500--
