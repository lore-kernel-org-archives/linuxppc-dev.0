Return-Path: <mchehab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id EDBB1B6FE3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 23:50:37 +1000 (EST)
Message-ID: <4F9D46F8.1020104@redhat.com>
Date: Sun, 29 Apr 2012 10:49:44 -0300
From: Mauro Carvalho Chehab <mchehab@redhat.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@amd64.org>
Subject: Re: [PATCH EDACv16 1/2] edac: Change internal representation to work
 with layers
References: <1335289087-11337-1-git-send-email-mchehab@redhat.com>
 <1335291342-14922-1-git-send-email-mchehab@redhat.com>
 <20120427133304.GE9626@aftab.osrc.amd.com> <4F9ABCEC.9090807@redhat.com>
 <20120428090523.GD26065@aftab.osrc.amd.com>
In-Reply-To: <20120428090523.GD26065@aftab.osrc.amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>,
 =?ISO-8859-1?Q?Niklas_S=F6d?= =?ISO-8859-1?Q?erlund?=
 <niklas.soderlund@ericsson.com>, Tim Small <tim@buttersideup.com>,
 "Arvind R." <arvino55@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Olof Johansson <olof@lixom.net>, Doug Thompson <norsk5@yahoo.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>,
 Michal Marek <mmarek@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 28-04-2012 06:05, Borislav Petkov escreveu:
> On Fri, Apr 27, 2012 at 12:36:12PM -0300, Mauro Carvalho Chehab wrote:
>> The fix for it were in another patch[1], as calling them as "rank" is
>> needed also at the sysfs API.
> 
> No, this doesn't fix it either:
> 
> [   10.486440] EDAC MC: DCT0 chip selects:
> [   10.486443] EDAC amd64: MC: 0:  2048MB 1:  2048MB
> [   10.486445] EDAC amd64: MC: 2:  2048MB 3:  2048MB
> [   10.486448] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   10.486450] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   10.486453] EDAC DEBUG: amd64_debug_display_dimm_sizes: F2x180 (DRAM Bank Address Mapping): 0x00000088
> [   10.486455] EDAC MC: DCT1 chip selects:
> [   10.486458] EDAC amd64: MC: 0:  2048MB 1:  2048MB
> [   10.486460] EDAC amd64: MC: 2:  2048MB 3:  2048MB
> [   10.486463] EDAC amd64: MC: 4:     0MB 5:     0MB
> [   10.486465] EDAC amd64: MC: 6:     0MB 7:     0MB
> [   10.486467] EDAC amd64: using x8 syndromes.
> [   10.486469] EDAC DEBUG: amd64_dump_dramcfg_low: F2x190 (DRAM Cfg Low): 0x00083100
> [   10.486472] EDAC DEBUG: amd64_dump_dramcfg_low:   DIMM type: buffered; all DIMMs support ECC: yes
> [   10.486475] EDAC DEBUG: amd64_dump_dramcfg_low:   PAR/ERR parity: enabled
> [   10.486478] EDAC DEBUG: amd64_dump_dramcfg_low:   DCT 128bit mode width: 64b
> [   10.486481] EDAC DEBUG: amd64_dump_dramcfg_low:   x4 logical DIMMs present: L0: yes L1: yes L2: no L3: no
> [   10.486485] EDAC DEBUG: f1x_early_channel_count: Data width is not 128 bits - need more decoding
> [   10.486488] EDAC amd64: MCT channel count: 2
> [   10.486493] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc(): allocating 3692 bytes for mci data (16 ranks, 16 csrows/channels)
> [   10.486501] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 0: rank0 (0:0:0): row 0, chan 0
> [   10.486506] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 1: rank1 (0:1:0): row 0, chan 1
> [   10.486510] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 2: rank2 (1:0:0): row 1, chan 0
> [   10.486514] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 3: rank3 (1:1:0): row 1, chan 1
> [   10.486518] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 4: rank4 (2:0:0): row 2, chan 0
> [   10.486522] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 5: rank5 (2:1:0): row 2, chan 1
> [   10.486526] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 6: rank6 (3:0:0): row 3, chan 0
> [   10.486530] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 7: rank7 (3:1:0): row 3, chan 1
> [   10.486534] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 8: rank8 (4:0:0): row 4, chan 0
> [   10.486538] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 9: rank9 (4:1:0): row 4, chan 1
> [   10.486542] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 10: rank10 (5:0:0): row 5, chan 0
> [   10.486546] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 11: rank11 (5:1:0): row 5, chan 1
> [   10.486550] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 12: rank12 (6:0:0): row 6, chan 0
> [   10.486554] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 13: rank13 (6:1:0): row 6, chan 1
> [   10.486558] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 14: rank14 (7:0:0): row 7, chan 0
> [   10.486562] EDAC DEBUG: new_edac_mc_alloc: new_edac_mc_alloc: 15: rank15 (7:1:0): row 7, chan 1
> 
> DCT0 has 4 ranks + DCT1 also 4 ranks = 8 ranks total.
> 
> Now your change is showing 16 ranks. Still b0rked.
> 
No, DCT0+DCT1 have 16 ranks, 8 filled and 8 empty. So, it is OK.

As I said before when you've pointed this bug (likel at v3 review), edac_mc_alloc
doesn't know how many ranks are filled, as the driver logic first calls it to 
allocate for the max amount of ranks, and then fills the rank with their info 
(or let them untouched with 0 pages, if they're empty).

Regards,
Mauro
