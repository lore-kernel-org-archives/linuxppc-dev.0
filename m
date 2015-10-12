Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 34B581A06A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 13:32:38 +1100 (AEDT)
Date: Mon, 12 Oct 2015 13:32:06 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Laurent Vivier <lvivier@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC v6 00/25] Re-use nvram module
In-Reply-To: <561AC137.9090809@redhat.com>
Message-ID: <alpine.LNX.2.00.1510121326110.23992@nippy.intranet>
References: <20150823104129.517600532@telegraphics.com.au>
 <561AC137.9090809@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Laurent,

On Sun, 11 Oct 2015, Laurent Vivier wrote:
> On 23/08/2015 12:41, Finn Thain wrote:
...
> > This patch series has been compile-tested for arm, m68k, powerpc and 
> > x86. The nvram and thinkpad_acpi modules were regression tested on a 
> > ThinkPad T43. The /dev/nvram functionality was also regression tested 
> > on a G3 PowerMac. The nvram module was also tested on a PowerBook 520, 
> > Quadra 650 and Atari Falcon. AFAIK, no testing has been done on PPC64 
> > as yet.
> 
> For PPC64, tested on a PowerMac G5 (PowerMac11,2), kernel 4.3.0-rc4
> with nvram tools 1.2.24 (Fedora 22 ppc64).
> 
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> 
> Tests done:
>  # modinfo nvram
>  filename:       /lib/modules/4.3.0-rc4+/kernel/drivers/char/nvram.ko
>  alias:          devname:nvram
>  alias:          char-major-10-144
>  license:        GPL
>  depends:
>  intree:         Y
>  vermagic:       4.3.0-rc4+ SMP mod_unload
> 
>  # modprobe nvram
>  [  364.655577] Non-volatile memory driver v1.3
> 
>  # nvram --partitions
>   # Sig Chk  Len  Name
>   0  5a  82  0002 nvram
>   1  5f  45  003e system
>   2  70  bd  00c1 common
>   3  a0  1e  0052 APL,MacOS75
>   4  a1  15  0081 APL,OSXPanic
>   5  7f  45  002c wwwwwwwwwwww
> 
>  # nvram --dump "nvram"
>  0x00000000  5a820002 6e767261 6d000000 00000000 |Z...nvram.......|
>  0x00000010  cae8613d 000001c9 00000000 00000000 |..a=............|
> 
>  # nvram --print-config=boot-volume
>  1
> 
>  # nvram --update-config=boot-volume=6
> 
>  # rmmod nvram
> 
>  # nvram --print-config=boot-volume
>  6
> 
>  # reboot
> 
>  # nvram --print-config=boot-volume
>  6
> 

Thanks very much for taking the trouble to test this series.

I will add your Tested-By tag to the relevant powerpc patches and re-send.

Regards,
Finn
