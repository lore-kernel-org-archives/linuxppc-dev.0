Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C456F67BDA
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:42:49 +1100 (EST)
Date: Thu, 14 Dec 2006 10:42:16 +0900 (JST)
Message-Id: <200612140142.kBE1gINa003786@toshiba.co.jp>
To: linas@austin.ibm.com
Subject: Re: [PATCH 6/15] hypervisor console driver for Celleb
In-Reply-To: <20061212194107.GD4329@austin.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas-san,

Thanks for your comment.

> On Tue, Dec 12, 2006 at 12:31:29PM +0900, Ishizaki Kou wrote:
> > +
> > +static int hvc_beat_get_chars(uint32_t vtermno, char *buf, int cnt)
> > +{
> > +	unsigned long kb[2];
> > +	unsigned long got;
> > +
> > +	if (beat_get_term_char(vtermno, &got, &kb[0], &kb[1]) == 0) {
> > +	   memcpy(buf, kb, got);
> > +		       return got;

> This seems to completely ignore "cnt". Thus, I presume that
> beat_get_term_char might return more chars than there is room for in buf,
> thus corrupting something, somewhere.

This depends "beat_get_term_char" returns only one character at once
(for now), and assumes cnt > 0. This assumption will reduce code for
now.

> > +static int hvc_beat_put_chars(uint32_t vtermno, const char *buf, int cnt)
> > +{
> > +	unsigned long kb[2];
> > +
> > +	memcpy(kb, buf, sizeof(kb));
> > +	beat_put_term_char(vtermno, cnt, kb[0], kb[1]);
> > +	return cnt;
> > +}

> I can't imagine how this can possibly work. 
> What if "cnt" is greater than 8?

This routine assumes that 0 <= cnt <= 16, that is already checked by
caller. (Note that "unsigned long" is 8 bytes long at ppc64)

Best regards,
Kou Ishizaki
