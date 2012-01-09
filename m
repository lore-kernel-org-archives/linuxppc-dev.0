Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 8CBCAB6FC5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 09:40:45 +1100 (EST)
To: smitha.vanga@wipro.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Mac address in the DT
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <40631E9A2581F14BA60888C87A76A1FE01D360@HYD-MKD-MBX4.wipro.com>
References: <40631E9A2581F14BA60888C87A76A1FE01D360@HYD-MKD-MBX4.wipro.com>
Date: Mon, 09 Jan 2012 23:40:27 +0100
Message-Id: <20120109224027.A8B591167AA4@gemini.denx.de>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear smitha.vanga@wipro.com,

In message <40631E9A2581F14BA60888C87A76A1FE01D360@HYD-MKD-MBX4.wipro.com> you wrote:
>  
> >Setenv set_mac 'cp 0xffec0000 0x100000 1024;fdt addr 0xc00000 8192;fdt set=
>  /soc8272@f0000000/ethernet@24000 mac-address "[00 44 00 55 00 66]";erase 0x=
> ffec0000 0xffec4000;cp 0xc00000 0xffec0000 1024;bootm 0xfe060000 - 0xffec000=
> 0'
> 
> > run set_mac
> 
> For the above command I want to replace the mac address with the ethaddr> How
> do I do that. I tried $ethaddr but I get extra : characters.

Why would you do that at all?  U-Boot will run fdt_fixup_ethernet()
for all (at least AFAICT) supported architectures, which will replace 
"mac-address" and "local-mac-address" for all "ethernet?" interfaces
in the device tree for which a corresponding "ethadd" / "eth?addr"
environment variable is set.

No additional actions are needed.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"One day," said a dull voice from down below, "I'm going to  be  back
in  form again and you're going to be very sorry you said that. For a
very long time. I might even go so far as to make even more Time just
for you to be sorry in."              - Terry Pratchett, _Small Gods_
