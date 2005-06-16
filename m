Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
In-Reply-To: <42B1EBFC.4020105@smiths-aerospace.com>
References: <20050616070816.GE31347@localhost.localdomain>
	<1118954956.25372.71.camel@cashmere.sps.mot.com>
	<42B1EBFC.4020105@smiths-aerospace.com>
Content-Type: text/plain
Message-Id: <1118957816.25372.103.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 16 Jun 2005 16:36:56 -0500
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>,
	u-boot-users <u-boot-users@lists.sourceforge.net>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: More dtc changes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-06-16 at 16:15, Jerry Van Baren wrote:

> > And, um, rats.  So, I'm the victim of an aggressive
> > and anti-social IT Firewall poo-poolicy....  Or maybe I
> > am just being dumb and haven't Googled up the Right Magic.

Door number 3, I am dumb.

> > Is there a way to set an HTTP Proxy definition, flag,
> > parameter, environment variable, or other doo-dad that
> > will help me cg-pull/git-http-pull through my firewall?


> It ain't efficient and it is pull-only, but it works:

Good enough....

> $ cg-clone http://www.ozlabs.org/~dgibson/dtc/dtc.git
> defaulting to local storage area
> 17:13:12 
> URL:http://www.ozlabs.org/%7Edgibson/dtc/dtc.git/refs/heads/master
> [41/41] -> "refs/heads/origin" [1]
> progress: 40 objects, 59841 bytes

Hmmm... So, I tested this mess again.  This time, I did
NOT use our stupid SOCKS proxy, but rather the built-in
HTTP proxy foo sort of like this in an environment variable
sort of like this:

	setenv http_proxy http://$user:$password@$proxy_machine:$proxy_port
                
        cashmere.sps.mot.com 894 % socksify cg-pull origin
        loeliger@192.88.158.50.1090 sockspassword: 
        cg-pull: objects pull failed
                
        cashmere.sps.mot.com 895 % cg-pull origin
        16:24:36 URL:http://www.ozlabs.org/%7Edgibson/dtc/dtc.git/refs/heads/master [41/41] -> "refs/heads/origin" [1]
        FINISHED --16:24:48--

And then it just stupidly worked.

Pay no attention to my questions,
jdl
