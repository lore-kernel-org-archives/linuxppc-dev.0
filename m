Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx041.isp.belgacom.be (outmx041.isp.belgacom.be
	[195.238.6.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9907CDDE37
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 23:32:08 +1000 (EST)
Received: from outmx041.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx041.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l3HDW2E3025263
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 Apr 2007 15:32:03 +0200
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem cloning Linus' GIT tree!
Date: Tue, 17 Apr 2007 15:31:59 +0200
References: <18A49CF3586FC14290887ECC63C9141F0104D047@exchange2003.dspace.de>
In-Reply-To: <18A49CF3586FC14290887ECC63C9141F0104D047@exchange2003.dspace.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704171532.00215.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > > After a while however, git exits with the following error message:
> > >
> > >    error: Couldn't get
> > > http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/r
> > >efs/tags/v2.6.11 for tags/v2.6.11 The requested URL returned error: 404
> > >    error: Could not interpret tags/v2.6.11 as something to pull
> > >    rm: cannot remove directory
> > >   `/cygdrive/c/home/git/linux-2.6/.git/clone-tmp': Directory not empty
> >
> > Try upgrading git to the last version.
>
> I'm already using the latest version (1.5.1) of git but the error still
> persists. A "http 404" error usually reports that something is missing on
> the server. In fact, if I copy the URL above to web browser, the same error
> occurs.

I had the same issue some time ago. Git used to store tags in the .git/tags 
directory. Linus repository has somehow been 'stripped' from those tags, 
which are now stored in the git objects (I'm not sure if the repository has 
been stripped on purpose, or if the .git/tags directory is just deprecated).

I thought upgrading to a newer git release had fixed the problem, but after 
checking it turns out I had to switch to git:// as well. The http:// protocol 
might not support stripped repositories.

> Question:
>
> Do
> 	git://git.kernel.org
> and	http://www.kernel.org		<-- Note the *www*(!)
>
> physically access the same repository?  Or is the http server maybe just
> a mirror of the git server (which could mean that the two could be out of
> sync)

I'm not sure about that. The http repository is not broken, it's just 
stripped. The http:// protocol handler in git might need to be fixed.

> If all fails I could harass our company's network admins to open
> the git port in the firewall :-) but I'd prefer to fetch the tree
> via http.
>
> Any advice?  Is there anyone else who is using Linus' tree via http?

You could ask on the git mailing list or IRC channel.

Best regards,

Laurent Pinchart
