Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9F76967A79
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 11:59:08 +1100 (EST)
Date: Thu, 17 Feb 2005 16:59:05 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Stephen Williams <steve@icarus.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20050218005905.GC10915@gate.ebshome.net>
References: <42152ADD.8040104@icarus.com>
	<20050218004327.GB10915@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050218004327.GB10915@gate.ebshome.net>
Subject: Re: Linux processes, tempfs and programs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 17, 2005 at 04:43:27PM -0800, Eugene Surovegin wrote:
> On Thu, Feb 17, 2005 at 03:38:05PM -0800, Stephen Williams wrote:
> > My embedded system is structured such that the main user-mode
> > processes that are being run are downloaded and executed on demand.
> > I'm currently downloading the executable to an ext3 system on the
> > CompactFlash, but there is really no reason to use non-volatile
> > memory so I'm thinking to download to a tempfs directory and
> > execute from there.
> > 
> > But if I do that, I want to remove the program from the directory
> > after I start it, so that the file does not take up ram space. Will
> > that actually work? I'm using exec(2) to execute the program file
> > wherever it is downloaded. Will a subsequent unlink of the file
> > have a result, or will the file continue to take up space as
> > backing store for the executable?
> 
> I think unlink will remove the file from directory (so you won't be
> able to see it with ls), but it will still continue to to take space -  
> you're right it will be used as backing store, at least for read-only 
> segments, which can be discarded if memory is tight. Even if you mlock 
> all executable in memory, I think there will be still at least one 
> reference to this file, which will prevent freeing tmpfs memory.

A little correction, according to tmpfs doc, it lives completely in 
page cache, so I think memory is not wasted for unmodified sections of 
the loaded file (e.g. a second copy, when file is executed and loaded 
into user-space, isn't being made).

But as usual, make some measurements first :)

--
Eugene.
