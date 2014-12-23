Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7BE71A0A50
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 20:52:00 +1100 (AEDT)
Date: Tue, 23 Dec 2014 10:51:21 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 3/4] perf Documentation: add event parameters
Message-ID: <20141223095121.GA22265@krava.brq.redhat.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141222143943.GB29096@krava.brq.redhat.com>
 <20141222193436.GB19784@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222193436.GB19784@us.ibm.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 22, 2014 at 11:34:36AM -0800, Sukadev Bhattiprolu wrote:
> Jiri Olsa [jolsa@redhat.com] wrote:
> | On Sun, Dec 21, 2014 at 11:49:26PM -0800, Sukadev Bhattiprolu wrote:
> | > From: Cody P Schafer <cody@linux.vnet.ibm.com>
> | > +		In the case of the last example, a value replacing "?" would
> | > +		need to be provided by the user selecting the particular event.
> | > +		This is referred to as "event parameterization". All
> | > +		non-numerical values indicate an event parameter.
> | 
> | I see.. here's the glitch ;-) I thought we agreed on forcing '?'
> | as the value for param events, not 'All non-numerical values'
> 
> Yes, it is currently more broad than needed, but it is not really
> user input - we are just parsing sysfs entries that developer specified
> in the kernel. If necessary, we can tighten that independently ?

I think it's better to tighten it up from the beginning, so when
we decide later for other string usage, we will not breake the
'current behaviour'.

Like if now we allow users (kernel pmu modules) to put anything
as param event's value, we will brake their expectations/code if
we later decide for another usage of that string value.

As Cody wrong in last version thread:
---
Compared to monopolizing all strings (which is what I did when
initialy writing this), using a '$' prefix would allow less pain when
some events suddenly need non-integer parameters.
---

thanks,
jirka
