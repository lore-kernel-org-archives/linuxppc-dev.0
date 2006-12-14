Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1D3D67D56
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 04:36:44 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBEHafQn027401
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:36:41 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBEHafNt104716
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:36:41 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBEHaeej015742
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:36:40 -0500
Date: Thu, 14 Dec 2006 11:36:36 -0600
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 6/15] hypervisor console driver for Celleb
Message-ID: <20061214173636.GU4329@austin.ibm.com>
References: <20061212194107.GD4329@austin.ibm.com>
	<200612140142.kBE1gINa003786@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200612140142.kBE1gINa003786@toshiba.co.jp>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 14, 2006 at 10:42:16AM +0900, Ishizaki Kou wrote:
> Linas-san,
> 
> Thanks for your comment.
> 
> > On Tue, Dec 12, 2006 at 12:31:29PM +0900, Ishizaki Kou wrote:
> > > +
> > > +static int hvc_beat_get_chars(uint32_t vtermno, char *buf, int cnt)
> > > +{
> > > +	unsigned long kb[2];
> > > +	unsigned long got;
> > > +
> > > +	if (beat_get_term_char(vtermno, &got, &kb[0], &kb[1]) == 0) {
> > > +	   memcpy(buf, kb, got);
> > > +		       return got;
> 
> > This seems to completely ignore "cnt". Thus, I presume that
> > beat_get_term_char might return more chars than there is room for in buf,
> > thus corrupting something, somewhere.
> 
> This depends "beat_get_term_char" returns only one character at once
> (for now), and assumes cnt > 0. This assumption will reduce code for
> now.

But it will break in the future. If new firmware is released for beat,
that returns more than one char, then it will silently corrupt old kernels
on rare occasions, making the problem hard to find. What's more, the 
firmware people might forget to tell you about thier change, and
so you won't submit a matching update to the linux kernel. (Or you may
have a new job by then, or have lost interest/got bored, etc.)
Years later, someone will finally debug the problem, after a long and
difficult search, and they'll curse this code.  Better do it right, now.

> > > +static int hvc_beat_put_chars(uint32_t vtermno, const char *buf, int cnt)
> > > +{
> > > +	unsigned long kb[2];
> > > +
> > > +	memcpy(kb, buf, sizeof(kb));
> > > +	beat_put_term_char(vtermno, cnt, kb[0], kb[1]);
> > > +	return cnt;
> > > +}
> 
> > I can't imagine how this can possibly work. 
> > What if "cnt" is greater than 8?
> 
> This routine assumes that 0 <= cnt <= 16, that is already checked by
> caller. (Note that "unsigned long" is 8 bytes long at ppc64)

Actually, its N_OUTBUF which is currently defined to be 16. However,
that may someday change, in which case you'd have a bug, again.

--linas
