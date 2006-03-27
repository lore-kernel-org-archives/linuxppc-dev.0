Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id D98BC67B18
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Mar 2006 19:19:46 +1100 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by mail.skekraft.net (Postfix) with ESMTP id 6525FA4021
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Mar 2006 09:53:14 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Interpreting /proc/meminfo. How much free memory do I have?
Date: Mon, 27 Mar 2006 08:53:10 +0100
References: <20060327064907.23992.qmail@mx1.aruba.it>
In-Reply-To: <20060327064907.23992.qmail@mx1.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603270953.11079.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On m=E5ndag 27 mars 2006 08.49, antonio.dibacco wrote:
> Hi,
>
> I'm a little bit puzzled with the fields in /proc/meminfo. Which fields
> have I to sum up to get the amount of free memory?

=46rom a 2.6 /proc/meminfo

MemTotal:       515532 kB
MemFree:          6012 kB
Buffers:         79964 kB
Cached:          83264 kB
SwapCached:      82840 kB
Active:         294024 kB
Inactive:       130304 kB
=2D - -

Completely free is only MemFree. But those pages are only needed for
interrupt handlers (close enough).

Cached pages are also free but since they contain data that maybe will
be needed again (unmodified data that already is on disk) they are not
returned to MemFree state.

Inactive pages has not been in use for awhile and can be written out
if needed (some are probably unmodified and quick to get)

/RogerL
