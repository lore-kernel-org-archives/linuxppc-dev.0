Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55903B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 19:56:28 +1000 (EST)
Date: Fri, 2 Sep 2011 11:23:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/3] i2c: move of_i2c_register_devices call into core
Message-ID: <20110902112308.70745cc0@endymion.delvare>
In-Reply-To: <4E3C7B3C.1090100@gmail.com>
References: <1312579468-19365-1-git-send-email-robherring2@gmail.com>
	<1312579468-19365-2-git-send-email-robherring2@gmail.com>
	<20110805225435.GA6404@ponder.secretlab.ca>
	<4E3C7B3C.1090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Warren <swarren@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>, Dirk Brandewie <dirk.brandewie@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rob, Grant,

On Fri, 05 Aug 2011 18:22:36 -0500, Rob Herring wrote:
> Grant,
> 
> On 08/05/2011 05:54 PM, Grant Likely wrote:
> > On Fri, Aug 05, 2011 at 04:24:26PM -0500, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> All callers of of_i2c_register_devices are immediately preceded by a call
> >> to i2c_add_adapter or i2c_add_numbered_adapter. Add call to
> >> of_i2c_register_devices and remove all other callers.
> >>
> >> This causes a module dependency loop that is resolved by the next commit.
> > 
> > Wrong way around.  Don't break bisectability.  I'll leave it up to Ben
> > and Jean on weather or not they want to move this code.  I intend to
> > do the same thing for spi/gpio, but I maintain those subsystems so I
> > get to choose.  i2c is not up to me.
> 
> Well, I know, but it's only broken for bisect in the case of both being
> modules. So it's only run-time brokenness. That's better than the 3
> months it was broken before. I couldn't come up with a better way. The
> choices I thought of were:
> 
> -temporarily exporting and adding of_i2c_register_devices to i2c.h and
> then removing it. I'm not a fan of adding that churn.
> -just combining it all into 1 patch.

That would have been the right thing to do, yes. The two patches are
not so large, so the resulting merged patch would still be reasonable.
There's no point in splitting patches if they can't be applied in
sequence, bisected, and rejected, reverted or backported individually;
which is clearly not the case here.

But anyway, I don't buy the whole thing. We currently have a nice
separation between OF and the underlying bus types. Breaking it all
just for the sake of saving one call in 4 drivers (out of ~70 in the
current kernel tree) doesn't seem worth it, at all. It would make
things harder to maintain, too (I definitely do not want to maintain
OF-specific code).

If you are really worried about the extra call to
of_i2c_register_devices(), then maybe the of_i2c implementation is
incorrect, and you should rework it to build on top of
i2c_register_board_info() rather than i2c_new_device().

> -reverse the order and leave i2c device registration broken for 1
> commit. Thinking some more about it, perhaps that is a bit better than
> broken module loading. Guess it depends if you are doing modules or
> built-in.

-- 
Jean Delvare
