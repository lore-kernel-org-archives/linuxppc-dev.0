Return-Path: <olof@lixom.net>
Date: Thu, 10 May 2007 16:57:30 -0500
To: paulus@samba.org
Subject: arch/powerpc/sysdev: dumping ground or only for shared drivers?
Message-ID: <20070510215730.GA25075@lixom.net>
References: <20070510200237.GA19756@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510200237.GA19756@mag.az.mvista.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 01:02:37PM -0700, Mark A. Greer wrote:
> This is the latest and hopefully last round of patches for adding mv64x60
> and prpmc2800 support to arch/powerpc.  It would be great if this could
> still get into 2.6.22.

I know Mark wants this merged, and I'm not looking to hold that off,
however the following came up on IRC and I wanted to move it over here
for clarification/list archiving of the answers:


This adds yet another set of chipset drivers under sysdev, that are
only used by one platform (several board ports under that platform,
but only one platforms/* directory).

In my opinion, they really should go under the platform directory instead,
and not clutter the shared directory.

Same with tsi*, it should probably be moved, as well as the 8xx*
drivers. fsl_* seems to be shared, so does cpm2*.

embedded6xx has a handful of different chipsets, so it could make sense
to create a subdir under platforms/embedded6xx for chipset support,
but there's no need to keep them in sysdev.


Or is sysdev really supposed to be a dumping ground for all chipset
drivers, even those who are not shared between platforms?

If not, I'll be happy to bake up a patch that moves things out (unless
the platform maintainers want to do it themselves) for 2.6.23.


Thanks,

-Olof
