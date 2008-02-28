Return-Path: <jwilson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 59D9BDDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 14:33:57 +1100 (EST)
From: Jarod Wilson <jwilson@redhat.com>
To: linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] firewire: endianess fix
Date: Wed, 27 Feb 2008 22:33:47 -0500
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
	<200802271458.28401.jwilson@redhat.com>
In-Reply-To: <200802271458.28401.jwilson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802272233.48039.jwilson@redhat.com>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 27 February 2008 02:58:28 pm Jarod Wilson wrote:
> On Saturday 23 February 2008 06:24:17 am Stefan Richter wrote:
> > The generation of incoming requests was filled in in wrong byte order on
> > machines with big endian CPU.
> >
> > Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> > Cc: sparclinux@vger.kernel.org
> > Cc: linuxppc-dev@ozlabs.org
> > ---
> >
> > This patch is a shot in the dark, based on a warning when building with
> > C=1 CHECKFLAGS="-D__CHECK_ENDIAN__".  Is it really a fix, or was the
> > previous code accidentally correct?
> >
> > This needs to be tested on different big endian PCs, if possible with
> > the Apple Uninorth FireWire controller and other types of controllers.
> > One test which involves ohci->request_generation is simply with an SBP-2
> > device (harddisk, CD-ROM...).  Does SBP-2 login etc. work?
>
> Works just fine with the Apple UniNorth controller in my powerbook in
> cursory testing. Tested with multiple sbp2 hard disks, plugging and
> unplugging, mounting and unmounting, etc.
>
> > If possible, also test whether the device remains accessible after
> > forcing a bus reset, e.g. by "echo br short > firecontrol".  You need
> > the easy to build utility firecontrol and a libraw1394 with "juju"
> > backend.  See wiki.linux1394.org for directions.
>
> Forgot to check that it survived bus resets. Will try to double-check that
> tonight.

Survives bus resets just fine, including with ongoing I/O from an sbp2 disk.


-- 
Jarod Wilson
jwilson@redhat.com
