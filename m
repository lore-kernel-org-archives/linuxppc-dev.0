Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C1606A33A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gkA+8o/u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNjyl6b4pz2xGr;
	Tue, 10 Nov 2026 08:46:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794260767;
	cv=none; b=J/hdGY/FOPOIkswUHajYNS2LUXxHtPFAVsxiCNJ8XE/BowlLida2WEWooHdVOa9FgoR2BqXwWyHgzf4Z/TwbHjyUSuOmCeNGmN9ZzwXzrF8j7zHX0NJF2/bEuvRUg3wXs2x39r+dC3NylLRPU6IFWnOqfTFylLEht+0Kz1SVjUiGlysTzTBjWJY8mi+iLj4GDdnjRkE2MJpRXnrgJT1AXd08pvqs1s01r/f0NAVrxTaC/7f2VKKjU+9f83Lz1TUfnZyw6bT0MkdrigUdJElJjveUcDfT9bhG/GHXaM52MIIDRUY30P2qML0J2f6YBB4EXwY8kE3nANCFXrgPIthBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794260767; c=relaxed/relaxed;
	bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPaNW1ZFAwwMXoNcs6GKu4zN3j/CkWY1gsYMaBTDGUhKKiBpma7WxjBgCX7pfg29mj7FkcCe+wrrmTBTKuj1iDKxjFwvW+inSN2biCRLmGg8XGlTS9kuY8Q4E6VVxIrsPiMwB7v6Mz5+8neyKmPi4LLsTtQbVqxnjxtRdOtAFH/0jQ3la7gUjppNeWyYqyzgDNCe36MQIvJV3Tm6OoyLr3yVSvPe4QpD5WVuCFA5qWbZvr/yxztyZKKIvNJLpAI1Pzk2lr8Kf8Axg8u6jCEYUj+zDpA11Zzmf8qsOTx0IV1i1Lknm8FuibSXr3VAr7V5/0n6/6y4R9Zf0G9exrCIyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gkA+8o/u; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gkA+8o/u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNjyk1JMxz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 08:46:05 +1100 (AEDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-490a0e72588so737607f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794260761; x=1794865561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=gkA+8o/u1H1RYVU3U2GLRIm1Qygi+snjgdOP0LheFrmfszBG47apZNWgBOYwbdfUk3
         3ujOGParsJZfnIvcp0+B82qGzUgRzyy46F75PO6Ot2IhbVLjbuzcka1t2WkkssQYVj7/
         qnKQ6cbYu00Cy3Sua04zXONwa5W7+mkgRobZ4cpY4b07B6BMxgjI4fvQN5ExQ/Ul3P+q
         I+ZegzOL8k5uy0/QOMXbwre2osCj0l8ou1vYbn5l7+m5JGAfFA0mKPxWlB4agLUSBdyR
         OWWunKReXBi4BXQVLo+k0N/hm+PpbUD88oU1x3aKYpFGkOiAqK87mNTQ1MFahRrGl/8t
         0Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260761; x=1794865561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=DT3ROYDkAwjdt9hmlAf45u6vX4VzMQme/okV/AQitcwB2zADlYzUG6uW2k5se8huaT
         7KpVK1JA2fNrChpSP+htn6Vnu8K+ubJTRz2cH15i9jna+Ihw+qXfj++PL3yWvv2ZsRXW
         R6S458L3v30/XawA436tEozERGRoHePl7Q9ooi9PkztW4ZF4djHj5r/lSBAvXaPN42Ot
         IvHncKSv+AOl+9kiJlMqjXpg3oTJqw3AlDHfZ7SorvhabcgFKLAIx8Kx6PI4RBw7OeY8
         Xm7OF8ESfdoF/UEqRPVJvk8lC8E4kGzlC58K5hwCL4DyIHbLchuPY9nQcCY0a2F/C3xb
         epXg==
X-Forwarded-Encrypted: i=1; AL+hErGdSSNPN0zQAogr02vCG3FpkdZIPwj58Ml4fLVWUiXxdvDniqQWfDjaFlQyttMBvLiBFmsGbbpaNtD1ItQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/kXPcNzWLaeKvbF7ncz+UYgrnzpYDJickhyccP0YDrFp+WoOmv
	dJUwX0GjQeI8hv7pCDwIGi6qAzCWO/GGVD7T9Swdnu15SOYhPe6WxgqY
X-Gm-Gg: AYBFou3a/t+9FF/4fdNYzSyiZTh7yNLOYSVadZveVdfF17aSfQ3yWEgHueTbRrDBFxl
	umgM2C7/5LfCLahMCZAYM1mxoYgoyBa8CTS57Dtn+5sbg7qXaj7RTN5/1AkzZSg45srmraDUMVc
	uNc824n5R7jT+shE0v0m4DiIjGllP3XyEkXafKf8JQcIItv+nNoC8XJTLvylZ9k/oBafqRCW3LC
	lbol2dbmsuBydfzGsK1hGI3UfeOyGN9pMx6+ErZYAChyenu5wd3nSkma6m4IeXwg0BFIdmkGJP/
	HqjzDVzW8pSb8tKJ4agk4QaVmAR1Qx2+kIUUok0Tt5aHEB4TvaRkRF822XQlAjmYylmn4bIFtW3
	SmfxUMybDR5dmCUyWciJUxdpw7Rsq3OAKWIc6+94qVQe8m0S+UcTlMLgKNDm6sgcp8/o9eUIQUW
	QmURfLJUzBGNe/MHSG9JnRl4/y/Wb4EMWO+/YcnYNeN289ygayKYPM8/Tye2VDZeJyumYGPEI16
	BJcJYWYocvoVn9513oKlEJ5SUqF6kZ/wCZGMx+eJEhV+zYbUUc3N+15C885MrXFFSIy0UtCPCGR
	IHJ6rSOZ/thjxYk7u24THe2RxYIiqJ0d6RjuI9c0gq4LWiS6lY/073O3vhVJDZHN/A==
X-Received: by 2002:a05:6000:288d:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-4982b28aa42mr1487213f8f.3.1794260760763;
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm1213644f8f.10.2026.11.09.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Date: Mon, 9 Nov 2026 21:45:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
	<20261108185953.28054fb3@pumpkin>
	<alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 05:05:57 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Sun, 8 Nov 2026, David Laight wrote:
> 
> > > > While at it, I think it would be good to use this conversion as an
> > > > opportunity to replace "char *" by "void *", which will probably let
> > > > you drop several casts from users.    
> > > 
> > > So I tried that too. The thing is it drops exactly one u8 * cast in
> > > ntfs3's label write.   
> > 
> > Since char is now unsigned that one isn't even needed...  
> 
>  Please excuse me missing the context, but what circumstances does your 
> claim refer to?

Just that the cast would have to be:
	u8 *foo = (u8 *)bar;
where 'bar' is 'char *', and I don't think you need a cast there when
char is unsigned.

David
 
> 
>   Maciej
> 


