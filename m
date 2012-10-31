Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 291EF2C009F
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2012 17:40:42 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 31 Oct 2012 02:40:39 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8E3736E8036
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2012 02:39:47 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9V6dlkY309284
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2012 02:39:47 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9V6dkdi007610
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2012 04:39:47 -0200
Date: Tue, 30 Oct 2012 23:40:56 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
Message-ID: <20121031064056.GA12061@us.ibm.com>
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com>
 <20121016100809.GS8285@erda.amd.com>
 <20121016183148.GA25482@us.ibm.com>
 <1351081662.22332.13.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351081662.22332.13.camel@twins>
Cc: Robert Richter <robert.richter@amd.com>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 eranian@google.com, acme@redhat.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
 mpjohn@us.ibm.com, mingo@kernel.org, asharma@fb.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Tue, 2012-10-16 at 11:31 -0700, Sukadev Bhattiprolu wrote:
| > On a side note, how does the kernel on x86 use the 'config' information in 
| > say /sys/bus/event_source/devices/cpu/format/cccr ? On Power7, the raw
| > code encodes the information such as the PMC to use for the event. Is that
| > how the 'config' info in Intel is used ?
| > 
| > Does the 'config' info change from system to system or is it static for
| > a given event on a given CPU ? 
| 
| Have a look at commits (tip/master):
| 
|   641cc938815dfd09f8fa1ec72deb814f0938ac33
|   a47473939db20e3961b200eb00acf5fcf084d755
|   43c032febde48aabcf6d59f47cdcb7b5debbdc63
| 
| 
| So basically
| 
|  /sys/bus/event_source/devices/cpu/format/event
| 
| contains something like:
| 
|   config:0-7
| 
| Which says that for the 'cpu' PMU, field 'event' fills
| perf_event_attr::config bits 0 through 7 (for type=PERF_TYPE_RAW).
| 
| The perf tool syntax for this is:
| 
|   perf stat -e 'cpu/event=0x3c/'
| 
| This basically allows you to expose bitfields in the 'raw' event format
| for ease of writing raw events. I do not know if the Power PMU has such
| or not.

Thanks for the detailed explanation.

Power does not support this yet, but I have started working on it now.

BTW, does this mean that we can use arch-specific names for the sysfs entries
within:

	/sys/bus/event_source/devices/cpu/events/

So instead of the names I came up with in this patch, stalled-cycles-fixed-point
we could use the name used in the CPU spec - 'cmplu_stall_fxu' in the arch
specific code ?

Sukadev
