Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A6B4DDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:38:47 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0C0cfVU023914
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:38:41 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0C0cgP0303884
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:38:42 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0C0cfeD025784
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:38:41 -0500
Date: Thu, 11 Jan 2007 18:38:41 -0600
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
Message-ID: <20070112003841.GM6177@austin.ibm.com>
References: <45707469.9060604@austin.ibm.com> <4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
	<458EBE02.3010401@austin.ibm.com>
	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>
	<20070109150519.GD8122@localdomain>
	<45A55380.9020402@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45A55380.9020402@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Nathan Lynch <ntl@pobox.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 10, 2007 at 02:58:40PM -0600, Manish Ahuja wrote:
> Nathan Lynch wrote:
> > Paul Mackerras wrote:
> >   
> >> Manish Ahuja writes:
> >>
> >>> During power outages, the ups notifies the system for a shutdown. In the 
> >>> current setup, it isn't possible to power on when power is restored. 
> >>> This patch fixes the issue by calling the right ibm,power-off-ups token 
> >>> during such events. It also adds a proc interface so that rc.powerfail 
> >>> can parse the epow events and modify the power-off behavior accordingly 
> >>> to enable the right token to be called.
> >>>       
> >> Creating new non-process-related files in /proc is frowned upon these
> >> days, so we'll have to find somewhere in /sys for this.  Anybody got a
> >> suggestion?
> >>     
> >
> > Maybe a sysctl instead?
> >   
> Wouldn't sysctl be /proc/sys/something again.

?? where?

> I did look under /sys but couldn't come up with a location to create 
> this new file.

Candidates are /sys/class/rtas  or /sys/devices/system/rtas 
or /sys/devices/system/of_platform or /sys/firmware 
or /sys/platform

I'd have to do some study & research to figure out which location
would be appropriate.

> Although creating new files under /proc is frowned upon, the subset of 
> files in the directory
> seemed similar in functionality and connected to the new file I was 
> creating and hence this new file in
> /proc/ppc64/rtas.
> 
> linux:/proc/ppc64/rtas # ls -x
> .         ..          clock    error_log  frequency  poweron  poweron_auto
> progress  rmo_buffer  sensors  volume

It would make sense to move some or all of these over to the new
location as well.

--linas
