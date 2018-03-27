Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0224.hostedemail.com
 [216.40.44.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409MBl1jWmzF24x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 17:52:13 +1100 (AEDT)
Message-ID: <1522133524.12357.56.camel@perches.com>
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 patches@opensource.cirrus.com
Date: Mon, 26 Mar 2018 23:52:04 -0700
In-Reply-To: <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
References: <1522096136.12357.21.camel@perches.com>
 <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
> On 03/26/2018 01:28 PM, Joe Perches wrote:
> > drivers/hwmon is the most frequent user of symbolic permissions
> > like S_IRUGO in the kernel tree.
[]
> I have something similar using coccinelle,

Please post the script.
I expect it doesn't work quite the same as checkpatch.

> which has the added benefit
> of also adjusting multi-line alignments.

That's a benefit, but it's makes it difficult to review.
I also have the same patch rewrap alignment post this
automated patch, done with emacs formatting.

This patch is somewhat simpler to review which is why
it's not sent along with this script.

> But then I am hesitant to pull
> it in because I don't really see the point. A more intelligent approach
> would be to convert hwmon drivers to the latest API, and/or to introduce
> more intelligent macros such as SENSOR_DEVICE_ATTR_{RO,RW,WO}.

Another approach would be to separate the const bits
from the non-const bits to reduce data.

> But that
> would require active work as well as reviewers, and especially the latter
> is extremely difficult if not impossible to find for the hwmon subsystem.

[]

> Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
> that is maybe not entirely surprising, and I think we are good as we are.

Maybe true.

> I am happy to accept patches updating permissions as other changes are made
> to a file, but I don't see a pressing need to change all files just to make
> statistics happy (and backports more difficult).

Not sure backports are a real issue.

If it were a real issue, the updated permissions are noise
and shouldn't be accepted for the other changes.
