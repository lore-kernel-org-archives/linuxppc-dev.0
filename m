Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503DD60A2624
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gwvgnEIp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQsyd3Y88z3bSw;
	Fri, 13 Nov 2026 20:53:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794563609;
	cv=none; b=fn6jffyCV/6MEwhTWTCYDsdEHodRwSRZMNO1ZmLHKCTEImMFXMoToiU8hKyWCdXvU6qitge99j6XFJ1rBuLXhQa5l+aaVGPixoeOtKWR3NcJOsRDSqn2vN4qFtKy9uAXOu0o32BbGK6csbgkrQ4MSHcSeBmraNuQFEWJa5hW8Woly5ZvF2/NPKMr7m84K3B6Shy6OB92vF63t/Go5GttnL49Kxk2KoUpRZdDC1Zc1kP79UPj8b0abIuVbtSbFZH76fD/Ppo9eJPOJKhOHUVimlpd/IjY1kuNh6k8UbAjCwwz5mip/JM3Hl9P1ltEB27KpIUXi++E9K/E2KYi8TJZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794563609; c=relaxed/relaxed;
	bh=YoFgYXhwNNf5+XbqoLKJqW74RYsYuq6O4XrGk+Ibyu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rpjwq/zcbK2wJxfQCGl1II03RD1OBQdqzLe80HP66jl7Q0FB/Vabug4gaOBI/SgewaQeLHbvh/mGN+9YMQAux6YY1qfDtIY9nKt3TZ8NWW1xeRtS3MB0QzukXrRRva7TV3+kuEel4nbw/GSf7GMLpY9hjaO7nihW5V0WZ1ohDB2I7GR5MIOL3HR957KyQLMRjM4dnqlHpPdOIhtBWq7hVqLk4T3CpWXW97EpL55rREl+iEHERaEywYJy++/CTBDygcLFKpxcn6s85TKJXCt3Z7OcgHvUPR5Ir6XWg4NcxbKiwv0Egl4PxTsqXrFw6NE+fuc4jG33mD2PpW931SSEAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gwvgnEIp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gwvgnEIp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQsyZ4qJ4z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 20:53:25 +1100 (AEDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-4d7034a99a9so988354b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563603; x=1795168403; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YoFgYXhwNNf5+XbqoLKJqW74RYsYuq6O4XrGk+Ibyu4=;
        b=gwvgnEIpI7+Qa7pTG4rPVrk3eN0Buk+4cet7JZAYMbQaIcBDj4j/QI3UiN8oJpYkxK
         5pWjXYa/G79snxW7D49Jytk9IuubelBC0BL7vKJVvDz9ap94Q1vL02Nqz0mIG36Zhfgu
         c5mduxAMqZqRSMo8zRBRGc/+Ue/1U3zoTTWRVcuq/bRKarjfiwc+bzwv1uCAhyu5ibfB
         jzG5PXX8QjoHGarfhtauh7ty5F9Ww8VhSA3/iA2TkGClhVF9TIJU0LNDawLEY5Iv736z
         DBDIx69/R3MEG/2xP7f6eD4L0eBOUSWi+iQbyZpYd26ZA+jaVTRgxpS2l7KMufmQYgzr
         Ow3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563603; x=1795168403;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YoFgYXhwNNf5+XbqoLKJqW74RYsYuq6O4XrGk+Ibyu4=;
        b=Rvfk13xSImlplZfZnnNTWK09FUy17gh2jy5bSINGxZfcW4S3ZZURO+UBOQ/1t+PUjz
         ivqhavpJvY4Z+0wxkRXoPXLWhCotys0ERBQhLI20B6rCaEQbfEwu30nRiCfHl31ZjOP3
         QacdF/mH8mi2Fh84H6Ny2mBzReXtN+kLaV1RmVhIThv1WU8Ss6BU+7/5dLGTCFW1O/Q7
         wMvVjNluFW/D4ca6OC+GaOf1Jto15q9kpPXx6otd3pp4j2XFZReTscxJWKKNqg9kFA/G
         AcfZR5jYq/Ow/OXvdnaGPa+Z/LUX3C95Fygicu++gwOd/o7RD3YlsTmoe+++hRi4Pst0
         KwVg==
X-Forwarded-Encrypted: i=1; AL+hErHwTw90PPNcyvlKQLfyapX7KNhsx6kZznot0GNDIii4u4HG5Op5f3kAQQxtRzWvihevmSuWcyRYkPCrUsk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+1vmiay7Vz6MYgSLB4hazq3Z2PhKCxvZYi+dQoQHFeZzkBAp6W
	NDx6HTPKzQhcjHe0cfRdrarCKLOGIlN38SisZG5zxK7aN2zDYgmqn1Uq
X-Gm-Gg: AYBFou00c1/6qQCQoH9BR37wPG1tpVj9kgh7PSftKVW4nH4v7gWhpfqgaHT9L8A4fzF
	ulc/uwuIY1pPwuGor9A7dZRDlWk+95VkHTOTqnW8sdt9jp2BZ/33hxMg5A66QqDqjpbXBJgWrVg
	QFHapiFZ9Ff8F9oOBtyENUpTwDp9soj0J++XtSJaH+5pDEJuvNPouDvQNwXjSoCyPKGw7e00pxD
	pzcTuT45cYPvnkxCBHRd5dY/WJJEqgTrlmZHxH5EmuBqvokF4Do5txPX4JBzqwa74oE49uh14TC
	bnXplkQUgaurMiY+z3bxWTmXRZpJKTpz4N0apEyn1Zuk6+p/6v/sfTqvnxkgoLy322GLouXzYpc
	Ty1jK2YM6soWdwZZwGpHNF9A+P06LM2DNGFS8JTzCvqorgQXnV2vRy0AhB3Vddxf7euqLg4aLMM
	yLcJt9GVJR2YShT9ACuwVHHu63tCZAakIfjLNQHBNdyUx0NUMOEFOSNpxIMY/69PgWKdw46vZFV
	qyLf6EqkREQcIfTRf1JUzlc9KAE5m+1Ki6PO2RzJnzOkp1dDfhxckQlb+YAgRqjH6hMrc2aI+t1
	TcFr7RGf++lVxxhLBoDif8ci+rVW1Na3hqXovEv2JPciHc2dcJkV9HYlS56W64Vr/GVNnxg+dkZ
	YN8vJrB0BPIECcerWSkrapt97MrqJnuIQ5YVLl9NUq/uhKoJiftSNu4OC/bICgzT6APiJVpIuZy
	XXQJ5XT3uZ/Vi/AVnUbZZ0WmPXrWtZ4DfZQrpi6Sz7Cm6wvA1M5Mw=
X-Received: by 2002:a05:6808:f15:b0:4d6:90d3:e183 with SMTP id 5614622812f47-56e641d5735mr1541057b6e.44.1794563602591;
        Fri, 13 Nov 2026 01:53:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v13 0/8] serial: 8250: serialize DMA cancellation with
 buffer reuse
Date: Fri, 13 Nov 2026 02:53:13 -0700
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XUzW7bMAwA4Fcpcp43kZIosqe9x7CDfsg2Q9NuS
 VpsKPruo9MBc10M8AIjgAzpIylRft6d9LjX0+766nl31Kf9af9w7wOIH652/bbe3+i0H/5ihwE
 JAsJ0emyH/Xma19W7iTGHaRzq1Ot917vpCaaGgY2TsnTYOfP9qLb/eYnx5evr2I1v2s+zO89o9
 aRTO7pwO7/yCUf98emfEcIf1Sc9esLnV/pV6Q8Hz+76ighZy0idGubOA9ggpqyxYhgIjFKrFk0
 Xqp77rZd5fRUppGa1xgodIYmUoWAAQNgYasoJquXa3q4qMkaQaNZiVsxJi4ThI2Yu5vOhUTJJ5
 e0qDjUHgsGph5wrpV7I95hNmw4o0olLE7FVrNFa8iSrgTGBMHajmlrJeUTppj0nRoxvV6XA7JG
 gYmleW/VKMESPAl6l12sIUgrxKhZ5gjakYfTkPDXEYpZAk5fLooxOpbiKNdgxKhEhjNoZR6yjt
 gS5sBlaIctM2GWVIVMWzWrRsu9jKSN4TWCBY+hhaCIR9GW7uYNu96fzw/HXpWmf4HL429vTnzC
 pqZ+oGMYQP98c6v7uo3fOBX/CJYgbQHTQN1hrBo0ssAbjEowbwOjg8O0STT1JxDWY/hdMc8kli
 3czR/9fg3kJpg1gdtCPC4VYkMe7DOl/QXKQLJJ3AVgmWoNlCZYNYJkz5Fx9g5rfj7QGeQnKBpA
 djDYytRoz6liD8hd0cQMoc4aQpdfq55J4Dfp3biHyls4O8zmTX9MxmuT2rhMBluSWqmG+LRQp6
 eiV4nh3MLC4Lv7bQuKlefxrTK1jznlJvry8/AbLk7c2lAYAAA==
X-Change-ID: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reserve canceled transmit and receive storage until DMA and its completion
callbacks have retired. Serial-core write backpressure protects a flushed
TX FIFO while normal transfers continue to DMA directly from that FIFO.

The preparatory patches separate OMAP's locked TX completion processing,
serialize asynchronous write wakeups, and fix OMAP RX locking and shutdown
ordering. Serial-core reservation helpers then protect 8250 TX storage.
Flushing empties the logical queue immediately. While the old transfer owns
its storage, write_room() reports zero and write-ready notifications wait for
retirement. Failed termination retains the reservation until normal
completion, without advancing the reset FIFO. DMA retirement releases the
reservation independently of port readiness. Serial core keeps writes and
write-ready notifications gated during shutdown until successful startup
or resume. Flushes still notify threads waiting for the logical FIFO to
empty, independently of whether its storage can be reused.

RX delivers paused data before the PIO fallback and retires callbacks in
process context. Track FIFO access separately from buffer retirement so
PIO and the DesignWare empty-FIFO timeout handling can run once DMA has
released the FIFO. Initially retry ambiguous pause failures so a successful
pause or reported completion can make the buffer stable. Keep receive interrupts
masked meanwhile, preserving the requested enables in the IER shadow.
Back off pause retries from 1 ms and use synchronous termination after a
one-second retry budget. Report the discarded pending payload and allow new
RX DMA after the old transfer and callbacks have retired. Keep ownership
and RX masking while failed termination retries back off to one second;
completion and shutdown wake the worker immediately. Reset retry state for
each flush. Explicitly unsupported pause and confirmed DMA errors retain
the PIO fallback until reopen. Shutdown excludes new retirement work before
releasing the channels.

Final shutdown retains both channels and their storage until synchronous
termination succeeds. Retry failed channels outside the port lock, starting
with a 1 ms sleep and doubling it up to one second to limit sustained
retries. Report the initial error, ongoing failures at five-second
intervals tracked separately for each teardown, and recovery once both
channels have stopped and drained. A permanently failed DMA engine blocks
teardown while retaining its storage and callback state.

DMA providers must supply the callback-drain guarantee of
dmaengine_synchronize() before retirement releases storage. The related
provider synchronization fixes are tracked separately and must precede
these consumer changes on affected controllers. Classic DesignWare needs
the callback synchronization series v6 [8]. The DW AXI termination and
pause fixes v5 [9] preserve transfer ownership on a failed stop and allow
pause retries; the Tegra capability fix v2 [10] excludes hardware without
pause support before RX DMA admission.

Based on tty-next at 6628e7d4c6b2 with the posted shutdown guard [0], channel
configuration error handling [1], RX TTY accounting fix [2], RZ/N1
transfer-length fix [3], transmit-PM shutdown fix [4], serport
write-wakeup deferral v2 [5], DesignWare BUSY-safe fractional-divisor
programming [6], and Intel MID RX DMA timeout locking [7]. The serport fix
is needed before serializing the remaining write-wakeup callers with the
port lock.

[0] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-shutdown-v1-v1-1-3d3ce383c614@gmail.com
[1] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com
[2] https://lore.kernel.org/r/20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com
[3] https://lore.kernel.org/r/20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com
[4] https://lore.kernel.org/r/20261022-submit-serial-8250-tx-pm-shutdown-v1-v1-1-0e894afa3bb8@gmail.com
[5] https://lore.kernel.org/r/20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com
[6] https://lore.kernel.org/r/20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com
[7] https://lore.kernel.org/r/20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com
[8] https://lore.kernel.org/r/20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com
[9] https://lore.kernel.org/r/20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com
[10] https://lore.kernel.org/r/20261109-submit-tegra186-dma-pause-caps-v1-v2-1-accf568bf0cc@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v13:
- Extract the locked RX flush retry step and tie the timeout diagnostic
  directly to the failed attempt, following Andy's review.
- Share the initial and repeated DMA termination calls in a do/while loop,
  retaining each channel's successful retirement and the retry timing.
- Group the serial-core transmit declarations after the write-wakeup helper
  and add the requested spacing before the DZ port-lock guard.
- Reference the posted DW AXI termination and pause fixes v5.
- Link to v12: https://patch.msgid.link/20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com

Changes in v12:
- Move the OMAP EFR2 clear after IRQ draining so DMA handlers and the PIO
  timeout workaround cannot restore timeout behavior during shutdown.
- Collect Raul's Reviewed-by for RX DMA retirement.
- Link to v11: https://patch.msgid.link/20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com

Changes in v11:
- Bound ambiguous RX pause retries to one second, then stop and drain the
  old transfer before permitting new RX DMA, following Raul's proposal.
  Report the discarded payload without disabling DMA until reopen.
- Retry failed synchronous RX termination with exponential backoff, keeping
  FIFO and buffer ownership reserved and allowing shutdown to take over.
- Handle explicitly unsupported pause immediately and reference the latest
  posted provider synchronization, stop/pause and capability fixes.
- Keep the SB1250 modem-change condition on one line and use __set_bit()
  for the SCCNXP wakeup bitmap, following Andy's review.
- Collect Raul's Reviewed-by for retaining DMA resources on termination
  failure.
- Link to v10: https://patch.msgid.link/20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com

Changes in v10:
- Rebase onto tty-next at 6628e7d4c6b2, retaining the latest posted versions
  of the prerequisites.
- Warn once per stalled RX flush without a shared rate limit, so concurrent
  stalls on different ports and later stalls on the same port are reported.
- Remove OMAP shutdown notifications for the unused generic RX pause worker.
- Use consistent TX cancellation predicates and the shared RX-running helper,
  simplify condition formatting, and describe OMAP locking with Context:.
- Spell retry intervals as explicit multiples of the time-unit constants.
- Use the public bitmap header for SCCNXP wakeup iteration and leave the
  unrelated event-handler iterator type unchanged.
- Share and document the low-water write-wakeup check used by serial-core
  readiness and generic 8250/OMAP TX DMA completion.
- Explain why ambiguous pause failures retain the transfer instead of using
  timeout-triggered PIO recovery, distinguishing data preservation from
  termination safety and documenting the possible indefinite RX stall.
- Track final-termination progress reporting separately for each teardown,
  reporting ongoing failures at five-second intervals without a shared
  rate limiter. Keep the initial failure and recovery reports
  unconditional.
- Collect Raul's Reviewed-by tags for the first six patches.
- Link to v9: https://patch.msgid.link/20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com

Changes in v9:
- Back off pending RX pause retries from 1 ms to one second, wake the worker
  on completion and shutdown, and report prolonged stalls once per flush
  through a rate-limited warning. Reset the delay for each new flush.
- Lock ST ASC startup's transmit servicing and RX interrupt enable after
  requesting the IRQ, covering write wakeups from an empty FIFO as well.
- Wake logical-FIFO drain waiters after a flush even while TX storage is
  reserved or the port is not ready, keeping line-discipline write-ready
  callbacks deferred until writes are allowed.
- Use plain port locking where interrupt context or an enclosing IRQ-saving
  lock already supplies the required exclusion, retaining IRQ-saving locks
  in workers, tasklets and mixed-context callers.
- Separate OMAP RX completion/flush locking and shutdown IRQ draining into
  two preparatory fixes, with their own rationale and Fixes tags.
- Place the new delay header before the existing include block.
- Back off failed final DMA termination retries from 1 ms to a one-second
  cap. Report the initial failure, rate-limit ongoing failures with elapsed
  time and current RX/TX errors, and report successful recovery.
- Link to v8: https://patch.msgid.link/20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com

Changes in v8:
- Retain RX transfers after ambiguous pause failures and retry in the worker
  until pause succeeds or completion is reported, preserving delayed data
  while masking RX interrupts and allowing shutdown to take over.
- Retain both DMA channels and their storage during final shutdown until
  synchronous termination succeeds, retrying failures outside the port lock.
- Update the serport write-wakeup prerequisite to the posted v2.
- Cover DZ transmit servicing, DECstation ZS TX/modem handling and
  JSM Classic modem notifications with the port lock.
- Defer ZS console-triggered TX restart to a worker, preserving the
  port-before-SCC lock order and draining work during teardown.
- Release Lantiq's private hardware lock before write-wakeup callbacks.
- Assert the port-lock contract in uart_write_wakeup().
- Retain the tx_running guard in generic and OMAP TX callbacks.
- Publish OMAP's shutdown gate before the final RX flush, serialize
  RX completion and runtime-suspend flushes with port and RX DMA locks,
  and drain its UART interrupt before releasing DMA state.
- Link to v7: https://patch.msgid.link/20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com

Changes in v7:
- Rebase onto tty-next at 6b4b543fa187.
- Use v4 of the DesignWare BUSY-safe fractional-divisor prerequisite.
- Use an unsigned long bitmap and for_each_set_bit() for SCCNXP
  deferred write wakeups, with unsigned port indices.
- Narrow SB1250 modem-status locking to shared-state updates and
  avoid taking the port lock for RX-only interrupts. Keep TX FIFO
  consumption and interrupt masking serialized with writers.
- Link to v6: https://lore.kernel.org/r/20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com

Changes in v6:
- Use v2 of the DesignWare BUSY-safe fractional-divisor prerequisite.
- Serialize CLPS711x TX servicing and interrupt-enable state with the
  port lock. Use non-waiting IRQ disable in stop_tx(), skip queued TX
  interrupts after stopping, and drain the handler outside the lock
  during shutdown.
- Make the Atmel RX/TX tasklets and SB1250 termios locking IRQ-safe
  alongside their interrupt-handler locking, preserving the caller's
  interrupt state when releasing the port lock.
- Report RX DMA recovery after releasing the port lock, keeping the
  state changes and interrupt-enable restoration serialized.
- Link to v5: https://patch.msgid.link/20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com

Changes in v5:
- Add the posted serport write-wakeup deferral as a prerequisite for the
  caller-locking preparation.
- Add a preparatory patch serializing asynchronous write-wakeup callers
  with the port lock, including indirect CTS and transmit-helper calls.
  Keep sleeping register accesses outside the lock and defer SCCNXP
  notifications until its controller lock is released.
- Use the separately posted DesignWare BUSY-safe fractional-divisor fix
  and Intel MID RX DMA timeout locking fix as prerequisites, leaving five
  patches in this series.
- Separate serial-core write readiness from DMA storage reservations. Record
  retirement during startup and shutdown while keeping writes and wakeups
  gated until the port is ready.
- Wake deferred writers after successful startup or resume, including when
  reopening with a retained FIFO, and restart any retained queued output.
- Keep the write-ready notification pending while retained output is at or
  above the normal wakeup threshold, until TX completion drains it.
- Publish resume readiness under the TX restart lock without releasing a
  reservation that may belong to a newly flushed transfer.
- Release 8250's TX reservation after shutdown has stopped DMA and unmapped
  the source; serial core retains control of write readiness.
- Link to v4: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com

Changes in v4:
- Retain flushed TX reservations through shutdown and failed resume. Release
  them after successful resume, or when allocating a new FIFO on reopen,
  so retirement cannot wake writers into a closing port.
- Treat RX flush as complete once the channel is inactive, and clear the
  shutdown guard before startup configures the UART and tests interrupts.
- Check completion after a failed pause so a transfer that finished before
  its callback acquired the port lock is delivered and retired normally.
- Keep DesignWare's BUSY-safe divisor setter after fractional-divisor
  discovery, writing DLF and DLL/DLH only after confirming DLAB.
- Link to v3: https://patch.msgid.link/20261023-submit-serial-8250-dma-cancel-v1-v3-0-d78f9e4c4932@gmail.com

Changes in v3:
- Defer write-ready wakeups while flushed TX storage is reserved, and
  serialize the flush wakeup with the reservation under the port lock.
- Suppress ordinary TX starts during the reservation while preserving
  high-priority flow-control characters, which use separate storage.
- Separate RX FIFO access from callback retirement, allowing PIO and the
  DesignWare empty-FIFO timeout workaround after a successful pause and
  termination while keeping the receive buffer reserved.
- Use the existing IER shadow for requested enables and a shared register
  writer to keep receive interrupts masked throughout DMA error recovery,
  including termios, RS485, modem-status and overrun-backoff updates.
- Preserve the timeout-enable bit across stop_rx(), exclude late shutdown
  interrupts from PIO, and avoid FIFO resets during RX DMA recovery.
- Preserve the completion-path LSR read after stop_rx(), while gating DMA
  resubmission on the receive interrupt enable.
- Pack the cancellation flags after moving all their accesses under the
  port lock, including the recovery worker's snapshot and initialization.
- Apply the early-return, shared-helper and line-wrapping cleanups.
- Link to v2: https://patch.msgid.link/20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com

Changes in v2:
- Add serial-core helpers to reserve flushed transmit storage until DMA
  retirement. Apply write backpressure during that interval and keep normal
  TX using the FIFO directly, replacing the private transmit buffer in v1.
- Document the flush callback's reservation, writer backpressure and
  retirement requirements, including release before shutdown returns.
- Split the OMAP completion refactor into a preparatory patch and move
  the RZ/N1 preparation-order and shutdown PM fixes to independent
  submissions, keeping four patches in this series.
- Take runtime PM references around worker UART accesses, and leave normal
  RX retirement to release ownership without reading LSR or restarting DMA.
- Synchronize the queued TX ranges before preparing the descriptor and
  return the mapping to CPU ownership before releasing the reservation.
- Keep the TX transfer length separate from FIFO cancellation, so a failed
  termination can account completion without advancing the reset FIFO.
- Exclude late RX flush work during shutdown, including Intel MID DMA
  timeout interrupts which are independent of UART_IER.
- Accept DMA_IN_PROGRESS after successful pause, and recover from failed
  pause, termination or DMA_ERROR before handing the receiver to PIO.
- Preserve stop_rx() and shutdown across recovery, and retain the
  DesignWare empty-FIFO timeout workaround when receiving through PIO.
- Apply the requested guard spacing and container_of() formatting.
- Link to v1: https://patch.msgid.link/20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jacky Huang <ychuang3@nuvoton.com>
To: Shan-Chun Hung <schung@nuvoton.com>
To: Pali Rohár <pali@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Timur Tabi <timur@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Tony Lindgren <tony@atomide.com>
To: Raul E Rangel <rrangel@chromium.org>
To: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org

---
James Hilliard (8):
      serial: 8250_omap: separate locked TX DMA completion processing
      serial: serialize asynchronous write wakeups with the port lock
      serial: 8250_omap: serialize RX DMA completion and flushing
      serial: 8250_omap: quiesce DMA IRQ handling before shutdown
      serial: core: allow drivers to reserve flushed transmit storage
      serial: 8250: drain canceled TX DMA before reusing its buffer
      serial: 8250: retire canceled RX DMA before reusing the receive buffer
      serial: 8250: retain DMA resources when termination fails

 drivers/tty/serial/21285.c          |   2 +
 drivers/tty/serial/8250/8250.h      |  67 +++++-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/8250/8250_dma.c  | 452 ++++++++++++++++++++++++++++++------
 drivers/tty/serial/8250/8250_dw.c   |  28 ++-
 drivers/tty/serial/8250/8250_omap.c |  74 ++++--
 drivers/tty/serial/8250/8250_port.c |  36 ++-
 drivers/tty/serial/atmel_serial.c   |  12 +-
 drivers/tty/serial/clps711x.c       |  23 +-
 drivers/tty/serial/cpm_uart.c       |   2 +
 drivers/tty/serial/dz.c             |  10 +-
 drivers/tty/serial/fsl_lpuart.c     |   2 +-
 drivers/tty/serial/jsm/jsm_cls.c    |   6 +-
 drivers/tty/serial/jsm/jsm_neo.c    |   9 +-
 drivers/tty/serial/lantiq.c         |  12 +-
 drivers/tty/serial/ma35d1_serial.c  |   6 +-
 drivers/tty/serial/max3100.c        |   6 +-
 drivers/tty/serial/max310x.c        |   9 +-
 drivers/tty/serial/mux.c            |  13 +-
 drivers/tty/serial/mvebu-uart.c     |   2 +
 drivers/tty/serial/mxs-auart.c      |   2 +
 drivers/tty/serial/sb1250-duart.c   |  24 +-
 drivers/tty/serial/sccnxp.c         |  43 +++-
 drivers/tty/serial/serial_core.c    | 104 ++++++++-
 drivers/tty/serial/st-asc.c         |   2 +
 drivers/tty/serial/ucc_uart.c       |   6 +-
 drivers/tty/serial/zs.c             |  94 ++++++--
 drivers/tty/serial/zs.h             |   3 +
 include/linux/serial_core.h         |  35 ++-
 29 files changed, 862 insertions(+), 224 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261021-submit-serial-8250-dma-cancel-v1-b208f84e89c1
prerequisite-patch-id: 3604bfaa3a1c214997de1f11162b81a4541af5ab
prerequisite-patch-id: 79dd093ffb35e254e790dffb8887faf51b64f947
prerequisite-patch-id: 80a5061d84c055a64c760268febed179c687b99f
prerequisite-patch-id: 7dbb404baf1f861982cf6a4b755d39cfec548223
prerequisite-patch-id: 40881d81a27b3a1aa45203d171214faaf2197768
prerequisite-patch-id: 76506fd9b234c7268227ff41e4d0989e82a1a433
prerequisite-patch-id: d8219673210dac82d3adab41578ff2f76f5862c9
prerequisite-patch-id: 48659e5ef3f5fb377d0b751f0830c0de4699262c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


