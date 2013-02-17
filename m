Return-Path: <jacmet@gmail.com>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 971602C007C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 02:12:44 +1100 (EST)
Received: by mail-ee0-f50.google.com with SMTP id e51so2470280eek.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 07:12:39 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <1360970315-32116-1-git-send-email-dianders@chromium.org>
Date: Sun, 17 Feb 2013 16:12:31 +0100
In-Reply-To: <1360970315-32116-1-git-send-email-dianders@chromium.org> (Doug
 Anderson's message of "Fri, 15 Feb 2013 15:18:35 -0800")
Message-ID: <87txpboty7.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Kevin Hilman <khilman@ti.com>,
 Sonic Zhang <sonic.zhang@analog.com>, linux-arm-kernel@lists.infradead.org,
 Deepak Sikri <deepak.sikri@st.com>, Havard Skinnemoen <hskinnemoen@gmail.com>,
 Marek Vasut <marex@denx.de>, Pawel Moll <pawel.moll@arm.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Uwe =?utf-8?Q?Kleine?= =?utf-8?Q?-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>,
 uclinux-dist-devel@blackfin.uclinux.org, Jean Delvare <khali@linux-fr.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 Barry Song <baohua.song@csr.com>, linux-omap@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Oskar Schirmer <oskar@scara.com>, Fabio Estevam <fabio.estevam@freescale.com>,
 davinci-linux-open-source@linux.davincidsp.com,
 Shawn Guo <shawn.guo@linaro.org>, Jim Cromie <jim.cromie@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomoya MORINAGA <tomoya.rohm@gmail.com>, linux-kernel@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Viresh Kumar <viresh.linux@gmail.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>, Jiri Kosina <jkosina@suse.cz>,
 STEricsson <STEricsson_nomadik_linux@list.st.com>,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 Alessandro Rubini <rubini@unipv.it>, linuxppc-dev@lists.ozlabs.org,
 Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Doug" == Doug Anderson <dianders@chromium.org> writes:

 Doug> There is simply no reason to be manually setting the private driver
 Doug> data to NULL in the remove/fail to probe cases.  This is just extra
 Doug> cruft code that can be removed.

 Doug> A few notes:
 Doug> * Nothing relies on drvdata being set to NULL.
 Doug> * The __device_release_driver() function eventually calls
 Doug>   dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
 Doug>   twice.
 Doug> * I verified that there were no cases where xxx_get_drvdata() was
 Doug>   being called in these drivers and checking for / relying on the NULL
 Doug>   return value.

 Doug> This could be cleaned up kernel-wide but for now just take the baby
 Doug> step and remove from the i2c subsystem.

 Doug> Reported-by: Wolfram Sang <wsa@the-dreams.de>
 Doug> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
 Doug> Signed-off-by: Doug Anderson <dianders@chromium.org>

For i2c-ocores.c + i2c-mux-gpio.c:

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
