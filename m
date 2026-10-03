Return-Path: <linuxppc-dev+bounces-28810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24814CA5FC1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 04:51:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxYBc07QMz30Wh;
	Sat, 03 Oct 2026 14:51:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791003063;
	cv=none; b=hDNmOhc0jwpAv+pJTrUZXdxS4PI760XOAVyQpOW7s4OhNe6Vaunx0ICpH6+LNawT8UOHJoPgpsfM7T2YmfuxI1E/O90J1gUYXNNnZ3iYv9H/W3ei3XRXfSx3p+QWf7Vdd8OoIT9JEdeRNf3UIGZVvegf0/9cVODjogxyNfzDtp8gt4gmuXNZJ6cFlg3gyRVgEJz/Kc3+amZICYbSrOovskc5QBPMGJpU5Rn7+0e1uUSrv0wd20mRq+6lHKugUwjjNAAUwa4NzqgbdECU+K8frZ7P9EazmZghAKzXjjFOR2wtKfYu8Wg/YNSqSxuFJgz1QI7wrVPgCo8wW9VLySPBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791003063; c=relaxed/relaxed;
	bh=Rms+lxZF9z8Sb3tW2DEtvUlSOL076vw/3UOncHYJUyg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MyT5Rk6FBk6J76JslEWQuLamDro2YFa+NbnJnhbmRKQQDzdLA3+YlN8ZVLwPul/tzOFCMnC0+duZUN6B7DlKExT05P+InC1NC9FU8FUgB3KtbmLiiCo0Z4FoY5IX3n/v2lXcrCjfdUcDcHjp211udmwGRMuwg9nQ+zBu/hh5qyXo3/8q91p9yyeHkcCFfS+m2i55d9lnf/A2ZWCjKWnnaZ0CuCSK8UcBdcahnaA8M2Jt7Etif1RHscLQmcWpIZSNfkBnRa0NyXeYJtVJrvQWMPD06OwEz3XoMovaH5dtngN58PyUpVV/NDVQb8XAurmTZuc/PXhEcUQwpPvJDuXtNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBbDo+0V reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBbDo+0V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxYBb13r6z30Wd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 14:51:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C843F60D77;
	Sat,  3 Oct 2026 04:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5D01F000FF;
	Sat,  3 Oct 2026 04:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791003060;
	bh=Rms+lxZF9z8Sb3tW2DEtvUlSOL076vw/3UOncHYJUyg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fBbDo+0Vp4sT7OTMptP7l22LYB8DFYOrcLK/vYkPvZcJ+1tLNSluFTSR8w5+CU7OO
	 Z/P7q8xJZx9Ch9v4WxoYtayQIgWA1AR8hJI5cuckv1hd5CplgURaEej1xWJ0XeQ/Kp
	 RcMEF1gZP26pSpyQ3zX7vx6/xGv9y7Tc0zFbU1DHxrnrYboDuubDlX9iG/CrcoY4gH
	 +na8jpApp3q3WKCeHmywE5SnL3/CqIslhYvfH1FiZ75goNYT3GTK/edaL/NnwGRcAj
	 weC4lyRd3I8t3uNlZDjbgMSpTgoaGx6hemN7CdiEOGOBxFFyLSWSt9FfFbQNPaQLdM
	 K/M/wyhoP2/LQ==
Content-Type: multipart/mixed; boundary="===============1261292974183120383=="
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d56cb11faf507e24e879644226fdd67d0191840f3ed43153577f5f6ae6854236@mail.kernel.org>
In-Reply-To: <20261003035921.1918874-3-kees@kernel.org>
References: <20261003035921.1918874-3-kees@kernel.org>
Subject: Re: [PATCH v4 03/11] seq_buf: Copy what fits when seq_buf_puts() and seq_buf_putmem() overflow
From: bot+bpf-ci@kernel.org
To: kees@kernel.org,morbo@google.com
Cc: kees@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com, david@davidgow.net,
	pmladek@suse.com, shuvampandey1@gmail.com, rostedt@goodmis.org,
	corbet@lwn.net, senozhatsky@chromium.org, gnoack@google.com,
	mic@digikod.net, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	jikos@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
	chleroy@kernel.org, u.kleine-koenig@baylibre.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	sbhat@linux.ibm.com, blum@kernel.org, alison.schofield@intel.com,
	dave.jiang@intel.com, gregkh@linuxfoundation.org,
	lgs201920130244@gmail.com, iweiny@kernel.org,
	u.kleine-koenig@pengutronix.de, vishal.l.verma@intel.com,
	rdunlap@infradead.org, skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-k@lists.ozlabs.org, ernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 04:50:58 +0000 (UTC)

--===============1261292974183120383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> seq_buf: Copy what fits when seq_buf_puts() and seq_buf_putmem() overflow

TL;DR: seq_buf_puts() now copies a partial string on overflow, which may break
lpfc_rx_monitor_report(), which relies on whole-record drops. Debugfs output
could then end in a truncated record followed by a duplicate.

> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 35a5964370b4..60e9eadb3ef7 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c

[ ... ]

> @@ -194,6 +196,11 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
>  		s->len += len - 1;
>  		return 0;
>  	}
> +	/* Copy what fits, so the buffer never holds stale bytes */
> +	if (s->len < s->size) {
> +		strscpy(s->buffer + s->len, str, s->size - s->len);
> +		s->len = s->size;
> +	}
>  	seq_buf_set_overflow(s);
>  	return -1;
>  }

Can this break callers that rely on seq_buf_puts() dropping a string whole
when it does not fit?

lpfc_rx_monitor_report() in drivers/scsi/lpfc/lpfc_sli.c was converted to
seq_buf in 22d4cbf6f750 ("scsi: lpfc: Replace strlcat() with seq_buf in
lpfc_rx_monitor_report()"), and that changelog says seq_buf_puts() "appends
it only when it fits whole, so the output keeps ending at the last complete
record".  The code still documents this:

	/*
	 * Drop a record whole if it does not fit, without
	 * consuming its ring entry.
	 */
	scnprintf(tmp, sizeof(tmp), "%03d:\t%-16llu...", ...);

	if (seq_buf_puts(&s, tmp) < 0)
		break;

With this patch, a record that does not fit is now copied up to
buf[buf_len - 2] and NUL-terminated at buf[buf_len - 1] before the loop
breaks.

lpfc_rx_monitor_read() then returns strlen(buffer) bytes through
simple_read_from_buffer(), so the debugfs output ends in a truncated record
with no newline.

Since the loop breaks before *head_idx is advanced, the same ring entry is
printed again in full at the start of the next read, so the reader sees a
partial copy followed by a duplicate.

Both the old strlcat() code ("if ((strlen(buf) + strlen(tmp)) >= buf_len)
break;") and the seq_buf version before this patch dropped the record whole.

Getting there needs the 800 rows to average more than about 128 bytes in the
128 * LPFC_MAX_RXMONITOR_ENTRY buffer, which can happen when the u64/u32
counters (cmf_info, max_read_cnt, avg_io_latency, timer_utilization, ...)
are wider than their %-8/%-16 columns.

The commit message does not mention auditing seq_buf_puts() callers that
rely on the old semantics, and nothing later in the series changes lpfc.

Would it make sense to have lpfc_rx_monitor_report() check
strlen(tmp) < seq_buf_buffer_left(&s) before calling seq_buf_puts()?

The other callers I checked (setup_trace_event(), the usbhid name building,
the partition pp_buf users, string_stream_get_string(), dynevent_str_add()
and the hist command builders) either treat overflow as an error or used
strlcat() before, which also copied a partial string.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37096036516
--===============1261292974183120383==--

