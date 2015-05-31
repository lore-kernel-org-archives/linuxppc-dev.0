Return-Path: <hmh@hmh.eng.br>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C9881A0CA3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 00:34:28 +1000 (AEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id CA5F2207C7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 10:34:25 -0400 (EDT)
Date: Sun, 31 May 2015 11:34:22 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Darren Hart <dvhart@infradead.org>,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
Subject: Re: [RFC 07/24] x86/thinkpad_acpi: Use arch_nvram_ops methods
 instead of nvram_read_byte() and nvram_write_byte()
Message-ID: <20150531143422.GA12337@khazad-dum.debian.net>
References: <20150531010132.289674310@telegraphics.com.au>
 <20150531010134.129479218@telegraphics.com.au>
 <20150531041114.GA30431@khazad-dum.debian.net>
 <alpine.LNX.2.00.1505311605420.23528@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1505311605420.23528@nippy.intranet>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 31 May 2015, Finn Thain wrote:
> On Sun, 31 May 2015, Henrique de Moraes Holschuh wrote:
> > On Sun, 31 May 2015, Finn Thain wrote:
> > > Make use of arch_nvram_ops in the thinkpad_acpi driver so that the 
> > > nvram_* function exports can be removed.
> > > 
> > > This patch series was tested on a ThinkPad T43.
> > 
> > Can you describe how you did the testing?  A specific procedure is 
> > required to test the hotkey NVRAM polling codepaths (which will read 
> > several NVRAM bytes @10Hz by default) in a T43...
> > 
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > 
> > The patch looks correct, so I don't expect any problems.
> > 
> > Provided that your test procedure did enable hotkey NVRAM polling in the 
> > T43 and your hotkeys all still worked fine, you have my Acked-by.
> 
> The procedure I used was this,
> 
> 1. $ xev
> 2. # rmmod thinkpad_acpi
> 3. Press <Access IBM> key and confirm that xev does not report any
>    events.
> 4. # modprobe thinkpad_acpi
> 5. Press <Access IBM> key and confirm that xev now reports the key press 
>    events.
> 
> Is this sufficient?

No.  Please try:

modprobe thinkpad_acpi
echo 0xfb88c0 > /sys/devices/platform/thinkpad_acpi/hotkey_source_mask

test the hotkeys.  Please test several of them, as not all of them are
available through NVRAM polling... at least Fn+SPACE, Fn+F1..FN+F12

Please test the brightness keys. In the T43 we use "direct EC mode", which
depends on the NVRAM to sync with the SMBIOS firmware.

to reset the driver to normal mode, it is enough to do this:
echo 0 > /sys/devices/platform/thinkpad_acpi/hotkey_source_mask

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
