Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA2E62C0168
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2012 23:28:10 +1100 (EST)
Message-ID: <1351081662.22332.13.camel@twins>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 24 Oct 2012 14:27:42 +0200
In-Reply-To: <20121016183148.GA25482@us.ibm.com>
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com> <20121016100809.GS8285@erda.amd.com>
 <20121016183148.GA25482@us.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
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

On Tue, 2012-10-16 at 11:31 -0700, Sukadev Bhattiprolu wrote:
> On a side note, how does the kernel on x86 use the 'config' information i=
n=20
> say /sys/bus/event_source/devices/cpu/format/cccr ? On Power7, the raw
> code encodes the information such as the PMC to use for the event. Is tha=
t
> how the 'config' info in Intel is used ?
>=20
> Does the 'config' info change from system to system or is it static for
> a given event on a given CPU ?=20

Have a look at commits (tip/master):

  641cc938815dfd09f8fa1ec72deb814f0938ac33
  a47473939db20e3961b200eb00acf5fcf084d755
  43c032febde48aabcf6d59f47cdcb7b5debbdc63


So basically

 /sys/bus/event_source/devices/cpu/format/event

contains something like:

  config:0-7

Which says that for the 'cpu' PMU, field 'event' fills
perf_event_attr::config bits 0 through 7 (for type=3DPERF_TYPE_RAW).

The perf tool syntax for this is:

  perf stat -e 'cpu/event=3D0x3c/'

This basically allows you to expose bitfields in the 'raw' event format
for ease of writing raw events. I do not know if the Power PMU has such
or not.

Using this,

  /sys/bus/event_source/devices/cpu/events/cpu-cycles

would contain something like:

  event=3D0x3c

which one can use as:

  perf stat -e 'cpu/event=3Dcpu-cycles/'
  perf stat -e 'cpu/cpu-cycles/'

The tool will then read the sysfs file, substitute the content to
obtain:

  perf stat -e 'cpu/event=3D0x3c/'

and run with that.

Within all this, the perf_event_attr::config* field names are hard-coded
special, so 'cpu/config=3D0xffff/' will always work, even without sysfs
format/ specification and is equivalent to the raw event stuff we had
before.


If the Power PMU lacks any structure to the raw config, you could simply
provide sysfs event/ files with:

  config=3D0xdeadbeef

like content.
