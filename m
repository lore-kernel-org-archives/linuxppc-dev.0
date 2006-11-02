Return-Path: <kallepokki@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.198])
	by ozlabs.org (Postfix) with ESMTP id 0B54C67BAC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 17:03:17 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id z31so29497nzd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 01 Nov 2006 22:03:16 -0800 (PST)
Message-ID: <a425f86c0611012203y4d9923b4u126a27ca033844ea@mail.gmail.com>
Date: Thu, 2 Nov 2006 08:03:13 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Robin Gilks" <robin.gilks@tait.co.nz>
Subject: Re: 2.6.18 on mpc859t stuck in __delay
In-Reply-To: <45493B07.7030806@tait.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <45493B07.7030806@tait.co.nz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/2/06, Robin Gilks <robin.gilks@tait.co.nz> wrote:
> I'm sure this is a common one but I'm a bit stuck (like the target is
> really!!)
>
> I'm real confused about what options to enable for a generic 866 series
> target - I'm got CONFIG_MPC86xADS and CONFIG_FADS enabled in the
> platform section but I'm not clear as to whether that will cause the
> startup code to look for an ADS EPROM chip or look for a bd_t struct of
> data from the bootloader.

You should probably have just have CONFIG_8xx and
CONFIG_YOUR_OWN_BOARD defined. Don't enable these other boards, since
that just makes the code to access some board specific control
registers you don't have. This surely leads to machine check
exceptions or other erratic behavior. However, it may be useful to
grep all the CONFIG_MPC86xADS and CONFIG_FADS code sections, and check
if you should implement something similar to these code blocks that
applies to your own board.
