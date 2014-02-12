Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 865B92C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 22:13:40 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: Linux-3.14-rc2: Order of serial node compatibles in DTS files.
Date: Wed, 12 Feb 2014 12:00:04 +0100
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <OFB203CA90.B048F8AA-ONCA257C7C.0081A816-CA257C7C.0081DCE3@csc.com>
 <52FAB5A7.7080208@gmail.com>
In-Reply-To: <52FAB5A7.7080208@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201402121200.05074.arnd@arndb.de>
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org,
 Stephen N Chivers <schivers@csc.com.au>,
 devicetree <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 12 February 2014, Sebastian Hesselbarth wrote:
> On 02/12/2014 12:38 AM, Stephen N Chivers wrote:
> > Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote on

> >> I don't think the missing compatible is causing it, but of_serial
> >> provides a DT match for .type = "serial" just to fail later on
> >> with the error seen above.
> >>
> >> The commit in question reorders of_match_device in a way that match
> >> table order is not relevant anymore. This can cause it to match
> >> .type = "serial" first here.
> >>
> >> Rather than touching the commit, I suggest to remove the problematic
> >> .type = "serial" from the match table. It is of no use anyway.
> > Deleting the "serial" line from the match table fixes the problem.
> > I tested it for both orderings of compatible.
> 
> I revert my statement about removing anything from of_serial.c. Instead
> we should try to prefer matches with compatibles over type/name without
> compatibles. Something like the patch below (compile tested only)

That would probably be a good idea. However, I think in this
case we also want to remove the line from the driver, as it clearly
never works on any hardware and the driver just errors out for the
device_type match.

	Arnd
