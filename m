Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D5E83DE044
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 06:20:38 +1100 (EST)
Message-ID: <47F3DC59.20608@ru.mvista.com>
Date: Wed, 02 Apr 2008 23:19:53 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH 2/3][POWERPC][V2] Xilinx: of_serial support for Xilinx
	uart	16550.
References: <12071551351007-git-send-email-john.linn@xilinx.com>	<12071551354058-git-send-email-john.linn@xilinx.com>
	<20080402165222.2468414080A9@mail104-dub.bigfish.com>
In-Reply-To: <20080402165222.2468414080A9@mail104-dub.bigfish.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

John Linn wrote:

> The Xilinx 16550 uart core is not a standard 16550 because it uses
> word-based addressing rather than byte-based addressing. With
> additional properties it is compatible with the open firmware
> 'ns16550' compatible binding.

> This code updates the of_serial driver to handle the reg-offset
> and reg-shift properties to enable this core to be used.

> Signed-off-by: John Linn <john.linn@xilinx.com>

> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 87f4d84..af112d9 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2539,6 +2539,17 @@ platforms are moved over to use the flattened-device-tree model.
>                        differ between different families.  May be
>                        'virtex2p', 'virtex4', or 'virtex5'.
>  
> +      iv) Xilinx Uart 16550
> +
> +      Xilinx UART 16550 devices are very similar to the NS16550 such that they
> +      use the ns16550 binding with properties to specify register spacing and
> +      an offset from the base address.
> +
> +      Requred properties:
> +       - clock-frequency : Frequency of the clock input
> +       - reg-offset : A value of 3 is required

    I'm proposing you to use the already existing "big-endian" property ISO 
"reg-offset" (used in the  nodes describing OpenPIC, for example).

WBR, Sergei
