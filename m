Return-Path: <leigh@solinno.co.uk>
Received: from titan.server-plant.co.uk (titan.server-plant.co.uk [80.71.3.50])
	by ozlabs.org (Postfix) with ESMTP id 8DEA367A86
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 02:40:12 +1100 (EST)
Message-ID: <28322.195.212.29.91.1106840404.squirrel@195.212.29.91>
In-Reply-To: <20050127002831.GB3683@synergymicro.com>
References: <32862.82.10.231.190.1106765713.squirrel@82.10.231.190>
	<20050127002831.GB3683@synergymicro.com>
Date: Thu, 27 Jan 2005 15:40:04 -0000 (GMT)
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Rob Baxter" <robb@synergymicro.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: cmd_line and cmd_preset in arch/ppc/boot/simple/misc.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rob Baxter said:
> On Wed, Jan 26, 2005 at 06:55:13PM -0000, Leigh Brown wrote:
>> Could someone please confirm that I'm not going mad?  At least wrt
>> this ;-)  We have this code in misc.c:
>>
>> #ifdef CONFIG_GEMINI
>>         /*
>>          * If cmd_line is empty and cmd_preset is not, copy cmd_preset
>>          * to cmd_line.  This way we can override cmd_preset with the
>>          * command line from Smon.
>>          */
>>
>>         if ( (cmd_line[0] == '\0') && (cmd_preset[0] != '\0'))
>>                 memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
>> #endif
>>
>>         /* Display standard Linux/PPC boot prompt for kernel args */
>>         puts("\nLinux/PPC load: ");
>>         cp = cmd_line;
>>         memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
>>
>>
>> Surely the bit in the #ifdef is ineffective?  Also, as cmd_line is
>> initialised to zeros, I think this is better:
>>
>>         /*
>>          * If cmd_line is empty and cmd_preset is not, copy cmd_preset
>>          * to cmd_line.  This way we can override cmd_preset with the
>>          * command line from Smon.
>>          */
>>
>>         if ( (cmd_line[0] == '\0') && (cmd_preset[0] != '\0'))
>>                 memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
>>
>>         /* Display standard Linux/PPC boot prompt for kernel args */
>>         puts("\nLinux/PPC load: ");
>>         cp = cmd_line;
>>
>> As, in the general case, cmd_line[0] will always be zero and
>> cmd_preset[0] will always be filled, so no need for an #ifdef.
>>
>> If someone can confirm I'm not mistaken, I can send a patch...
>
> No, you're not going mad...
>
> This piece code, CONFIG_GEMINI, complements a piece code in the GEMINI
> specific boot code.  This piece of code is not part of the standard
> distribution.  What this compliment piece of code did was to pass an
> optional command line from the firmware to misc.c.

Hi Rob, thanks for the answer.  It was more the suggestion that the
code doesn't work: the bit in the #ifdef doesn't achieve anything
because just a few lines below it will *always* overwrite the
contents of cmd_line with the contents of cmd_preset...

Cheers,

Leigh.
