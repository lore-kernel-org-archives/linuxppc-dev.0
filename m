Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 97637DDF23
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 07:26:03 +1000 (EST)
Message-ID: <48A35167.6030001@harris.com>
Date: Wed, 13 Aug 2008 17:25:59 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<48A0676E.5020308@harris.com>
	<20080811170756.GA29827@oksana.dev.rtsoft.ru>
	<1218492032.8041.11.camel@pasglop> <48A19788.6050502@harris.com>
	<20080812140457.GA9103@oksana.dev.rtsoft.ru>
	<48A19BC2.8060008@ru.mvista.com>
	<20080812143110.GA23961@oksana.dev.rtsoft.ru>
In-Reply-To: <20080812143110.GA23961@oksana.dev.rtsoft.ru>
Content-Type: multipart/alternative;
	boundary="------------080306080207010309040200"
Cc: "Sparks, Sam" <SSparks@aclaratech.com>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, Stefan Roese <sr@denx.de>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080306080207010309040200
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit

Anton Vorontsov wrote:
> On Tue, Aug 12, 2008 at 06:18:42PM +0400, Sergei Shtylyov wrote:
>   
>> Anton Vorontsov wrote:
>>
>>     
>>>>>> 1. IDE status read does not work. (But am I understand correctly
>>>>>>   that IDE works well if IRQ is unspecified? Then this is hardly
>>>>>>   an issue.)
>>>>>> 2. IDE interrupt comes when it should not. I'd recommend to use
>>>>>>   oscilloscope to find out what is happening there, that is, if
>>>>>>   the drive actually deasserts its irq line after status read.
>>>>>>   If so, than this could be a PIC problem.
>>>>>>             
>>>>>> What is the platform on which you're observing the issue, btw?
>>>>>>             
>>>>> Another possibility is that you got the wrong interrupt number
>>>>> in the device-tree...
>>>>>           
>>>>> Ben.
>>>>>           
>>>> The platform is the AMCC Sequoia board.  We've built a little adapter to
>>>> connect a compact flash card to the processor bus.  I believe the
>>>> interrupt selection in the device tree is correct, and I've checked over
>>>> the u-boot settings for the IRQ line (active high, level sensitive). 
>>>>         
>>> IDE IRQs are active-low.
>>>       
>>    Only on the PCI and only in the native mode. Natively, the IDE INTRQ  
>> signal is active-high, rising edge triggering, as on ISA. You seem to 
>> have an invertor somewhere, if it's not a PCI chip...
>>     
>
> Ugh. Right you are, as always. I've just looked into mpc8349emitx
> schematics, there is indeed an inverter on the irq line.
>
> CF in True IDE mode is active-high, sorry.
>   

Ok, just to close this issue, my CF device is now working perfectly. 
Two problems, both my fault.  1) I thought the alternate registers used
the same reg-shift and offset, so the alt_command and alt_status were at
the wrong address, and 2) I was missing a pull-down on the IRQ line -
the sequoia eval board has it in the schematic, but it is marked "not
populated".

    Thanks to all for your comments and help,
    Steve


--------------080306080207010309040200
Content-Type: text/html; charset=windows-1251
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=windows-1251"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Anton Vorontsov wrote:
<blockquote cite="mid:20080812143110.GA23961@oksana.dev.rtsoft.ru"
 type="cite">
  <pre wrap="">On Tue, Aug 12, 2008 at 06:18:42PM +0400, Sergei Shtylyov wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Anton Vorontsov wrote:

    </pre>
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">1. IDE status read does not work. (But am I understand correctly
  that IDE works well if IRQ is unspecified? Then this is hardly
  an issue.)
2. IDE interrupt comes when it should not. I'd recommend to use
  oscilloscope to find out what is happening there, that is, if
  the drive actually deasserts its irq line after status read.
  If so, than this could be a PIC problem.
            </pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">What is the platform on which you're observing the issue, btw?
            </pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">Another possibility is that you got the wrong interrupt number
in the device-tree...
          </pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">Ben.
          </pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">The platform is the AMCC Sequoia board.  We've built a little adapter to
connect a compact flash card to the processor bus.  I believe the
interrupt selection in the device tree is correct, and I've checked over
the u-boot settings for the IRQ line (active high, level sensitive). 
        </pre>
      </blockquote>
    </blockquote>
    <blockquote type="cite">
      <pre wrap="">IDE IRQs are active-low.
      </pre>
    </blockquote>
    <pre wrap="">   Only on the PCI and only in the native mode. Natively, the IDE INTRQ  
signal is active-high, rising edge triggering, as on ISA. You seem to 
have an invertor somewhere, if it's not a PCI chip...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Ugh. Right you are, as always. I've just looked into mpc8349emitx
schematics, there is indeed an inverter on the irq line.

CF in True IDE mode is active-high, sorry.
  </pre>
</blockquote>
<br>
Ok, just to close this issue, my CF device is now working perfectly. 
Two problems, both my fault.  1) I thought the alternate registers used
the same reg-shift and offset, so the alt_command and alt_status were
at the wrong address, and 2) I was missing a pull-down on the IRQ line
- the sequoia eval board has it in the schematic, but it is marked "not
populated".<br>
<br>
    Thanks to all for your comments and help,<br>
    Steve<br>
<br>
</body>
</html>

--------------080306080207010309040200--
