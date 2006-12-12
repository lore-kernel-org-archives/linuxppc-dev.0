Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A0F367BC8
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 06:41:11 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBCJf9kW031731
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 14:41:09 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBCJf8Up515564
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 12:41:09 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBCJf8f8010095
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 12:41:08 -0700
Date: Tue, 12 Dec 2006 13:41:07 -0600
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 6/15] hypervisor console driver for Celleb
Message-ID: <20061212194107.GD4329@austin.ibm.com>
References: <200612120331.kBC3VUIZ016091@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200612120331.kBC3VUIZ016091@toshiba.co.jp>
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

On Tue, Dec 12, 2006 at 12:31:29PM +0900, Ishizaki Kou wrote:
> +
> +static int hvc_beat_get_chars(uint32_t vtermno, char *buf, int cnt)
> +{
> +	unsigned long kb[2];
> +	unsigned long got;
> +
> +	if (beat_get_term_char(vtermno, &got, &kb[0], &kb[1]) == 0) {
> +		memcpy(buf, kb, got);
> +		return got;

This seems to completely ignore "cnt". Thus, I presume that
beat_get_term_char might return more chars than there is room for in buf,
thus corrupting something, somewhere.


> +static int hvc_beat_put_chars(uint32_t vtermno, const char *buf, int cnt)
> +{
> +	unsigned long kb[2];
> +
> +	memcpy(kb, buf, sizeof(kb));
> +	beat_put_term_char(vtermno, cnt, kb[0], kb[1]);
> +	return cnt;
> +}

I can't imagine how this can possibly work. 
What if "cnt" is greater than 8?

--linas
