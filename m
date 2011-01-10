Return-Path: <nfont@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AA09B718C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Jan 2011 05:47:35 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0AIY7OS014630
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jan 2011 11:34:07 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p0AIlNXR160130
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jan 2011 11:47:23 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0AIlNW9017149
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jan 2011 11:47:23 -0700
Message-ID: <4D2B543A.3070609@austin.ibm.com>
Date: Mon, 10 Jan 2011 12:47:22 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/4] De-couple sysfs memory directories from memory
	sections
References: <4D2B4B38.80102@austin.ibm.com> <20110110184416.GA18974@kroah.com>
In-Reply-To: <20110110184416.GA18974@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Robin Holt <holt@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/10/2011 12:44 PM, Greg KH wrote:
> On Mon, Jan 10, 2011 at 12:08:56PM -0600, Nathan Fontenot wrote:
>> This is a re-send of the remaining patches that did not make it
>> into the last kernel release for de-coupling sysfs memory
>> directories from memory sections.  The first three patches of the
>> previous set went in, and this is the remaining patches that
>> need to be applied.
> 
> Well, it's a bit late right now, as we are merging stuff that is already
> in our trees, and we are busy with that, so this is likely to be ignored
> until after .38-rc1 is out.
> 
> So, care to resend this after .38-rc1 is out so people can pay attention
> to it?

I was afraid of this. I didn't get a chance to get it out sooner but thought
I would send it out anyway.

> 
> 
>> The root of this issue is in sysfs directory creation. Every time
>> a directory is created a string compare is done against all sibling
>> directories to ensure we do not create duplicates.  The list of
>> directory nodes in sysfs is kept as an unsorted list which results
>> in this being an exponentially longer operation as the number of
>> directories are created.
> 
> Are you sure this is still an issue?  I thought we solved this last
> kernel or so with a simple patch?

I'll go back and look at this again.

thanks,
-Nathan
