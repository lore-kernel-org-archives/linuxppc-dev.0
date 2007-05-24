Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B335DDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 03:35:01 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4OHYstx025877
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 13:34:54 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4OHYsX6269070
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 11:34:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4OHYsvX010920
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 11:34:54 -0600
Date: Thu, 24 May 2007 12:34:53 -0500
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/4] powerpc: Add EEH sysfs blinkenlights
Message-ID: <20070524173453.GJ5921@austin.ibm.com>
References: <20070523171328.GY5921@austin.ibm.com>
	<20070523171646.GA32380@austin.ibm.com>
	<20070523232256.GJ29914@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070523232256.GJ29914@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 23, 2007 at 06:22:56PM -0500, Nathan Lynch wrote:
> Hi Linas-
> 
> Linas Vepstas wrote:
> > 
> > Add sysfs blinkenlights for EEH statistics. Shuffle the
> > eeh_add_device_tree() call so that it appears in the correct
> > sequence.
> 
> ( blinkenlights? :)

Alles touristen und non-technischen looken peepers! Das machinkontrol is
nicht for gefengerpoken und mittengrabben. Oderwise is easy schnappen
der springenverk, blowenfus, und poppencorken mit spitzensparken. Der
machine is diggen by experten only. Is nicht fur geverken by das
dumpkopfen. Das rubber necken sightseenen keepen das cotton-picken hands
in das pockets. So relaxen, und vatchen das blinkenlights.

> To me this seems a somewhat terse changelog considering that the patch
> introduces a user-visible interface.  The changelog does not really
> say what the code is doing or why, or who will use it.

At this time, there are no planned user-space tools that would look
at this. Its intended primarily for sysadmins and service, to determine
what, exactly, is going on in the system. I'd been planning on adding 
this for years, but recent email exchanges made it clear that this needs 
to get done.

> > +#define EEH_SHOW_ATTR(_name,_memb,_format)               \
> > +static ssize_t eeh_show_##_name(struct device *dev,      \
> > +		struct device_attribute *attr, char *buf)          \
> 
> I have been frustrated by similar constructions more than once in the
> midst of debugging.  I know this has become a common practice with
> sysfs-related code, but using cpp to generate function names
> completely defeats grep etc. when you're trying to track down a
> problem, and I'd not like to see this sort of thing propagated.

I understand the frustration. But I also would hate to have 5 or 6
nearly identidical subroutines, one after the other. Perhaps the
answer is to avoid te ## pste token, and instead do something
like this:

+#define EEH_SHOW_ATTR(_fullname,_memb,_format)         \
+static ssize_t _fullname(struct device *dev,           \
+    struct device_attribute *attr, char *buf)          \

That way, grep will suceed in finding the "full name".

> > +void eeh_sysfs_add_device(struct pci_dev *pdev);
> > +void eeh_sysfs_remove_device(struct pci_dev *pdev);
> 
> Don't you need dummy static inline placeholders for CONFIG_EEH=n?

Hmm. I think these are only called fom the dlpar code, and 
neither dlpar nor pseries pci will work if eeh is config'ed off...

I don't know how to make CONFIG_PCI depend on CONFIG_EEH, though ... 
strange situation.

--linas
