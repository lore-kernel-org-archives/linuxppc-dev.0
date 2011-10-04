Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32035B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 01:37:44 +1100 (EST)
Received: from /spool/local by us.ibm.com with XMail ESMTP
	for <linuxppc-dev@lists.ozlabs.org> from <nfont@austin.ibm.com>;
	Tue, 4 Oct 2011 10:36:11 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p94EQfjx198780
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2011 10:35:26 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p94EJ4Ud002545
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2011 08:19:04 -0600
Message-ID: <4E8B15D4.9080104@austin.ibm.com>
Date: Tue, 04 Oct 2011 09:19:00 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm00@gmail.com>
Subject: Re: [PATCH] memory hotplug: Correct page reservation checking
References: <4E8098B9.1080702@austin.ibm.com>
	<20111003175022.50cbef7f.akpm00@gmail.com>
In-Reply-To: <20111003175022.50cbef7f.akpm00@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <gregkh@suse.de>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2011 07:50 PM, Andrew Morton wrote:
> On Mon, 26 Sep 2011 10:22:33 -0500
> Nathan Fontenot <nfont@austin.ibm.com> wrote:
> 
>> The check to ensure that pages of recently added memory sections are correctly
>> marked as reserved before trying to online the memory is broken.  The request
>> to online the memory fails with the following:
>>
>> kernel: section number XXX page number 256 not reserved, was it already online?
>>
>> This updates the page reservation checking to check the pages of each memory
>> section of the memory block being onlined individually.
> 
> Why was this only noticed now?  Is there something unusual about the
> way in which you're using it, or has nobody ever used this code, or...?
> 

As far as I know it is only the powerpc/pseries code that uses the feature that
allows memory blocks in sysfs to span multiple memory sections.  We do this
because on pseries memory add/remove is done on a per LMB basis and we can have
machine where an LMB spans multiple memory sections.

This was just noticed due to a lack of testing between the 2.6.38/39 kernels where
this feature originally went in and the current mainline kernel.

-Nathan
