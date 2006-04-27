Return-Path: <pantelis@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id 370B1679FB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 07:23:56 +1000 (EST)
From: Pantelis Antoniou <pantelis@embeddedalley.com>
To: u-boot-users@lists.sourceforge.net
Subject: Re: [U-Boot-Users] Re: FT u-boot shim
Date: Fri, 28 Apr 2006 00:25:41 +0300
References: <20060427194316.CBFBC353A57@atlas.denx.de>
	<44512C25.2080105@smiths-aerospace.com>
In-Reply-To: <44512C25.2080105@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604280025.41587.pantelis@embeddedalley.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 27 April 2006 23:40, Jerry Van Baren wrote:
> Wolfgang Denk wrote:
> > In message <44511C88.1010107@smiths-aerospace.com> you wrote:
> >> A thought that keeps recurring (but I've suppressed because I don't have 
> >> time to play...) is that it would be Really Cool[tm] to store the u-boot 
> >> env variables in a flat tree and then pass the env/tree to linux.  It 
> > 
> > If somebody wants to read the environment variables, you  don't  need
> > to create a flat tree from it.
> 
> Understood.  That is why it is Really Cool[tm] rather than Really 
> Useful[tm] ;-)
> 
> > Also, it doesn't solve the original problem as most of  the  informa-
> > tion  you  need to pass is NOT part of the environment (and shall not
> > become such a part).
> > 
> > Best regards,
> > Wolfgang Denk
> 
> I agree and disagree with the parenthetical part of your statement. 
> Agree because it _wouldn't_ be a part of u-boot (technically it would be 
> if someone put it in their default env for their specific board, but why 
> would denx.de care?).
> 
> Disagree because, while u-boot needs/uses some env variables, 
> engineers/companies/end users are free to add variables and, I dare say, 
> most do.  If a given board needs to pass certain non u-boot parameters 
> to linux, it would simply add that to its env (which already happens).
> 
> I'm not sure you (Wolfgang and Kumar) are following my thought fully (or 
> my ignorance is showing to everybody but me).  The thought is to change 
> the native format of the u-boot environment storage from the 
> key-string/value-string pairs to the flat tree (OpenFirmware) format 
> which still supports the same key-string/value-string capability (but 
> can do more than that).
> 
> The advantage, as I see it, is that it would be unifying and thus easier 
> to maintain the common variables (call it the GRand Unifying Flat Tree 
> (GRAFT) ;-).  One language (flat tree), no shims, equivalent key/value 
> utility (but a different underlying storage format), no visible 
> difference for the users (but potentially an upgrade challenge for 
> existing boards and env variables).
> 
> The disadvantage is that it would be disruptive to u-boot and may cause 
> some bloating and discomfort.
> 
> gvb
> (the naive)
> 
> P.S. For the non-USA readers: "may cause some bloating and discomfort" 
> is a standard disclaimer on medicines advertised on TV over here.
> 

Since I'm the guy responsible let me weigh in a bit.

For starters, yes it's possible to pass the whole env using the FT tree.
Use CONFIG_OF_HAS_UBOOT_ENV to pass the u-boot env to the FT tree.

As for the rest of the cat-fight, I'm afraid I don't have the energy
to jump in at the moment.

Perhaps tomorrow :)

Regards

Pantelis

> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> U-Boot-Users mailing list
> U-Boot-Users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/u-boot-users
> 
