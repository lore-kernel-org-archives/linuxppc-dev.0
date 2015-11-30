Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [43.229.61.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C182A1A08AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 13:09:21 +1100 (AEDT)
Message-ID: <1448849229.1204.1.camel@russell.cc>
Subject: Re: [PATCH V2] powerpc/powernv: Add a kmsg_dumper that flushes
 console output on panic
From: Russell Currey <ruscur@russell.cc>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 30 Nov 2015 13:07:09 +1100
In-Reply-To: <m3fuzrnc08.fsf@oc8180480414.ibm.com>
References: <1448421962-6174-1-git-send-email-ruscur@russell.cc>
 <m3oaegm24h.fsf@oc8180480414.ibm.com> <1448604913.1291.2.camel@russell.cc>
 <m3fuzrnc08.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-11-27 at 18:21 +1100, Stewart Smith wrote:
> Russell Currey <ruscur@russell.cc> writes:
> > On Fri, 2015-11-27 at 16:40 +1100, Stewart Smith wrote:
> > > Russell Currey <ruscur@russell.cc> writes:
> > > > On BMC machines, console output is controlled by the OPAL firmware and
> > > > is
> > > > only flushed when its pollers are called.  When the kernel is in a
> > > > panic
> > > > state, it no longer calls these pollers and thus console output does
> > > > not
> > > > completely flush, causing some output from the panic to be lost.
> > > > 
> > > > This patch adds a new kmsg_dumper which gets called at panic time to
> > > > ensure
> > > > panic output is not lost.  It accomplishes this by calling
> > > > OPAL_CONSOLE_FLUSH
> > > > in the OPAL API, and if that is not available, the pollers are called
> > > > enough
> > > > times to (hopefully) completely flush the buffer.
> > > 
> > > You may want to add to commit message that this depends on:
> > > https://patchwork.ozlabs.org/patch/547379/
> > > 
> > It doesn't *depend* on it, it's just preferred.  It still works with older
> > Skiboot versions.  I will mention it in the actual commit message for the
> > next revision, though.
> 
> More meaning that it depends on that patch being merged before, say the
> PCI hotplug patches, which add a *different* OPAL call at the same ID -
> and that it depends on *this* patch with *this* API rather than a
> modified one being merged.
> 
> Otherwise, if, say, I merged some other new OPAL call into skiboot
> first, this patch would likely cause all sorts of trouble.
> 
> It's also a handy hint to Michael to ensure the skiboot side of things
> is merged and okay before merging kernel things in.
> 
That's a very good point I hadn't considered.  I'll make a note of it next
revision, especially given there are some additional changes required on the
Skiboot side of things.
