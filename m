To: Amit.Lubovsky@infineon.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: u-boot on mbx860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 18 Sep 2003 16:48:39 +0200."
             <AD2F581BD7340A4C908AF1AFB066EA3B0E4819@ntah901e.savan.com>
Date: Thu, 18 Sep 2003 17:17:46 +0200
Message-Id: <20030918151751.3A948C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Amit,

in message <AD2F581BD7340A4C908AF1AFB066EA3B0E4819@ntah901e.savan.com> you wrote:
>
> The process has finished sucessfully but after switching the power and
> setting back the J4 jumper nothing came up.

I'm sorry, but I never used  a  MBX  board  with  PPCBoot  or  U-Boot
myself, so my experience is limited.

> EPPC-Bug>pflash 4000:83fff fc000100
>
> Source Starting/Ending Addresses      =00004000/00087FFE
>
> Destination Starting/Ending Addresses =FC000100/FC0840FE
>
> Number of Effective Bytes             =00083FFF (&540671)

There are two obvious errors here:

First, U-Boot must start at offset 0, not  0x100;  I  don't  know  if
FC000100  is  the correct address - if the "FC" prefix is correct (*)
then you must program the image to FC000000, not FC000100.

(*) The U-Boot configuration  for  the  MBX-Board  sets  TEXT_BASE  =
0xFE000000 so please double-check your address.

Second, the image size of >500  kB  is  wrong.  You  must  flash  the
"u-boot.bin" image, which should be in the 120..130 kB range.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Always borrow money from a pessimist; they don't expect  to  be  paid
back.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
