Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 3BC54DDD05
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 05:36:46 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so1925534nfc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 11:36:44 -0700 (PDT)
Message-ID: <528646bc0703121136g628bcaf7if0ef36f87d27dc6b@mail.gmail.com>
Date: Mon, 12 Mar 2007 12:36:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem in compiling a kernel module
In-Reply-To: <20070312170030.GA5613@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070312170030.GA5613@server.idefix.lan>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/12/07, Matthias Fechner <idefix@fechner.net> wrote:
> If I try now to compile to kernel I got the following error message:
> WARNING: drivers/i2c/chips/max6633.o - Section mismatch: reference to
> .init.data: from .text after 'cleanup_module' (at offset 0x196)
> WARNING: drivers/i2c/chips/max6633.o - Section mismatch: reference to
> .init.data: from .text after 'cleanup_module' (at offset 0x1a6)
> WARNING: drivers/i2c/chips/max6633.o - Section mismatch: reference to
> .init.data: from .text after 'cleanup_module' (at offset 0x1da)
> WARNING: drivers/i2c/chips/max6633.o - Section mismatch: reference to
> .init.data: from .text after 'cleanup_module' (at offset 0x1e2)
>
> What does that mean or how can debug or solve the problem?
>

Looks like you're trying to access inital data (which is freed after
module load) from regular code (which is not)

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
