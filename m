Return-Path: <pku.leo@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id D88AFDDFC5
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 20:28:15 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so104424anc.39
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 03:28:14 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1242155174-2513-1-git-send-email-wd@denx.de>
References: <1242155174-2513-1-git-send-email-wd@denx.de>
Date: Wed, 13 May 2009 18:28:09 +0800
Message-ID: <2a27d3730905130328m27743852w2d68a62ebc32ce31@mail.gmail.com>
Subject: Re: [PATCH] [PowerPC] MPC8272ADS: fix device tree for 8 MB flash size
From: Li Yang <leoli@freescale.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 13, 2009 at 3:06 AM, Wolfgang Denk <wd@denx.de> wrote:
> The current device tree for the MPC8272ADS assumes a mapping of 32 MB
> of NOR flash at 0xFE00.0000, while there are actually only 8 MB on
> the boards, mapped at 0xFF80.0000. When booting an uImage with such a
> device tree, the kernel crashes because 0xFE00.0000 is not mapped.
>
> Also introduce aliases for serial[01] and ethernet[01].
>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Scott Wood <scottwood@freescale.com>
> cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> I am not really sure what the typical flash size on MPC8272ADS boards
> is. The board I used for testing is marked as "Prototype", so it may
> not be the release configuration. On the other hand, the manual also
> says 8 MB, Vitaly Borduk confirms 8 MB on his board, too, and Scott
> Wood eventually tested only with cuImage which fixes up the localbus
> mappings, thus eventually concealing the issue.

The latest reference board I got also has an 8MB SIMM flash module
shipped in the box.

>
> I'm posting this as reference in case the 8 MB should turn out to be
> correct. -- wd

Although 8MB seems to be the common size used.  It can be very easy
changed as a pluggable module.  It might be better to make the code
working for any reasonable flash sizes.

- Leo
