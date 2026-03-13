Return-Path: <linuxppc-dev+bounces-18183-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D596107BCEA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 22:35:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXfT53Ggjz30hg;
	Sat, 14 Mar 2026 09:35:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773441337;
	cv=none; b=BtJoXzudK8VeryycjIgUvkk7X73oZaLfmppzg75E8B3VNi12gdXQDTl8IO2iQiqdoFVhN2isoMXbCYuKqPl4wa0INLqhZbtPdvz20noTC3nDEXty8F2prPdE1R8JfUT8kAwoXhBTOnNuv8W3lNUBHpJevEbwoQ2xoUJ8HTCKkBTtx7Y3YJqA2Ljdr87apOCrbVAcKcDqOUw0uq8+K9vvoGXqvsDGudAzqwrQNlyTk6R0WaBDmX5hJ8ga3kps6XFemB5QAQwKMil0Z3Ga/o0MHXH16kXSad7WthjNAg0l+1oarNTOC4IrHKEjVXczTl9yhsaEc7HwvuMhKj/0jFo4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773441337; c=relaxed/relaxed;
	bh=rYHLubuM7cj23eYgCtV6oqa/hYmSUkxkRp5IGGlAtbU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RceDZHfrxrOqNVbqHrWJRMGDmkIdzs5zuepndHHcetisl8/KmtuFYDMqAjtDldguOWqs3w0LwV8+MM3DICxdKvvtnngEAZTlYclwfZRfPsezWioeCARS/COP6SZL42uMhWP1SE9eTc9DRP3L+jHYCvjQbCjFxR6/GZ34bG1ysRLP1JKqjRDpQz9wNr8nO1mTbdzC1xG6QP7fDlxopctB7hGFIkPSvQYefWovQ4pZvdzPcIzl7hgo/Cdu+/uPQGxq+tNxG798r2shLU7Lf5HlCGZPUJuNUEqMw0SQeWR55IsTz7F1idIzI1PoJoDXkRvnMCvVoYKczyZgfXFdGENc2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VcP2stPL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sstabellini@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VcP2stPL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sstabellini@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXfT430m2z2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 09:35:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8179A6183E;
	Fri, 13 Mar 2026 22:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03834C19421;
	Fri, 13 Mar 2026 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773441334;
	bh=NCbvP5f6b/mCFhMJmC9j3yAfcF6UdIqCTsj5FlU2tpw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VcP2stPLlc45efG1ATlBlz89qWp35F/JjEqHryh0F3Y9bmzCUrIvK8yF87waJcNGc
	 SjKO/CMF5u+aetYSJTviVylA5gODS1qGJBfnvoDJ/NXbDFgzMrRFnbTTCztAzTGJ+T
	 K/N6GhQ/HtDORPD/UDERYQzIFc8WQxkHxYYOhfJgoUSmJ8TFt0GP6Y9MJNbkc07Cj6
	 8ufjgksNohKApFW9NTPO4YC8qdeh9jcKhG7/rW9wjkQFs/VzzyrgiRB9uQ0UNA4nwm
	 r0d3OefD5V5LYb1e3xz0prUX/BxkOyU6H9u07+GAenyFQYk5we8A19XiohfzUuwj/+
	 9F2EnCXuH/ZYA==
Date: Fri, 13 Mar 2026 15:35:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jason Andryuk <jason.andryuk@amd.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] hvc/xen: Check console connection flag
In-Reply-To: <20260312173845.47235-1-jason.andryuk@amd.com>
Message-ID: <alpine.DEB.2.22.394.2603131535200.1759048@ubuntu-linux-20-04-desktop>
References: <20260312173845.47235-1-jason.andryuk@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
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
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Mar 2026, Jason Andryuk wrote:
> When the console out buffer is filled, __write_console() will return 0
> as it cannot send any data.  domU_write_console() will then spin in
> `while (len)` as len doesn't decrement until xenconsoled attaches.  This
> would block a domU and nullify the parallelism of Hyperlaunch until dom0
> userspace starts xenconsoled, which empties the buffer.
> 
> Xen 4.21 added a connection field to the xen console page.  This is set
> to XENCONSOLED_DISCONNECTED (1) when a domain is built, and xenconsoled
> will set it to XENCONSOLED_CONNECTED (0) when it connects.

It should be XENCONSOLE_DISCONNECTED


> Update the hvc_xen driver to check the field.  When the field is
> disconnected, drop the write with -ENOTCONN.  We only drop the write
> when the field is XENCONSOLED_DISCONNECTED (1) to try for maximum
> compatibility.  The Xen toolstack has historically zero initialized the
> console, so it should see XENCONSOLED_CONNECTED (0) by default.  If an
> implemenation used uninitialized memory, only checking for
> XENCONSOLED_DISCONNECTED could have the lowest chance of not connecting.
> 
> This lets the hyperlaunched domU boot without stalling.  Once dom0
> starts xenconsoled, xl console can be used to access the domU's hvc0.
> 
> Update the console.h header to bring in the new field.
> 
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

Aside from the minor comment on the commit message:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/tty/hvc/hvc_xen.c          |  3 +++
>  include/xen/interface/io/console.h | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
> index 7f0b6262488c..c407592442cd 100644
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -139,6 +139,9 @@ static ssize_t domU_write_console(uint32_t vtermno, const u8 *data, size_t len)
>  	if (cons == NULL)
>  		return -EINVAL;
>  
> +	if (cons->intf->connection == XENCONSOLE_DISCONNECTED)
> +		return -ENOTCONN;
> +
>  	/*
>  	 * Make sure the whole buffer is emitted, polling if
>  	 * necessary.  We don't ever want to rely on the hvc daemon
> diff --git a/include/xen/interface/io/console.h b/include/xen/interface/io/console.h
> index cf17e89ed861..687949bdebb1 100644
> --- a/include/xen/interface/io/console.h
> +++ b/include/xen/interface/io/console.h
> @@ -19,6 +19,19 @@ struct xencons_interface {
>      char out[2048];
>      XENCONS_RING_IDX in_cons, in_prod;
>      XENCONS_RING_IDX out_cons, out_prod;
> +/*
> + * Flag values signaling from backend to frontend whether the console is
> + * connected.  i.e. Whether it will be serviced and emptied.
> + *
> + * The flag starts as disconnected.
> + */
> +#define XENCONSOLE_DISCONNECTED 1
> +/*
> + * The flag is set to connected when the backend connects and the console
> + * will be serviced.
> + */
> +#define XENCONSOLE_CONNECTED    0
> +    uint8_t connection;
>  };
>  
>  #endif /* __XEN_PUBLIC_IO_CONSOLE_H__ */
> -- 
> 2.34.1
> 

