Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Message-ID: <3FAB51D2.104@iti.fi>
Date: Fri, 07 Nov 2003 10:03:30 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Tord Andersson <Tord.Andersson@combitechsystems.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite zImage now working
References: <004B1D7A5257174C9044A1B7BD0E60ED447034@ratatosk.combitechsystems.com>
In-Reply-To: <004B1D7A5257174C9044A1B7BD0E60ED447034@ratatosk.combitechsystems.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tord Andersson wrote:

>Kate,
>
>Thanks for sharing your experiences with the MPC5200Lite card.
>Would it be possible for you to explain the steps you took to replace
>dbug with u-boot. Did you use dbug or a bdm?
>I am about to do the same thing, and fear that I might end up with a
>"dead" card if
>things go wrong : )
>
I actually did not eplace it all. I just compiled and programmed u-boot
to flash in diferent
address than 0xfff00000 I used 0xff800000 but it is not a good choice
because it
leaved big hole between dbug and uboot.May be the 0xfff40000 will be
more sensible choice.

Then i just loaded s-record image to RAM and copied it to flash in right
address.
To load it in diferent address that it is intended you should use -o option
because dbug can't load directly to flash.

Now, when i am more familiar  with u-boot and if i wish replace dbug
i recommend to first compile u-boot to ram address and then use ram-running
u-boot to erase dbug and program u-boot on the place. Of cource this kind of
procedures allways have risk to make dead board and then you will need
a WERY EXPENSIVE bdm tools reprogram it. So, loading u-boot
to alternate address is safest way.
Only inconvicienc of ths is that u-buut must be started grom dbug and so
one
extra step is needed.


Kate

--
+==================================================================+
! Kate Marika Alhola  Internet Technologies International Oy       !
! kate@iti.fi         Phone +358 400 740701 Fax   +358 9 8138715   !
! kate@iki.fi	      http://www.iti.fi    http://www.iki.fi/kate  !
+==================================================================+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
