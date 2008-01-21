Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 493DBDDE35
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 05:45:35 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so499484anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 10:45:34 -0800 (PST)
Message-ID: <fa686aa40801211045w7644cfc5tf11024bd0010b308@mail.gmail.com>
Date: Mon, 21 Jan 2008 11:45:34 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olaf Hering" <olaf@aepfle.de>
Subject: Re: [PATCH] autodetect serial console on efika
In-Reply-To: <20080121152900.GA8664@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070331150823.GA25421@aepfle.de>
	<20080121152900.GA8664@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/21/08, Olaf Hering <olaf@aepfle.de> wrote:
>
> Efika boards have to be booted with console=ttyPSC0 unless there is a
> graphics card plugged in. Detect if the firmware stdout is the serial
> connector.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Hrrrum; I think this is a good idea, but I'm not thrilled with the
approach.  Here are my concerns:

- Determining that linux,stdout-path points to a PSC should should be
done in common code.  It's useful for all 5200 boards, not just the
Efika.  (However, if 'failsafe' processing is efika specific, then it
can stay in efika.c).  This might be best done within the PSC driver
itself, but I'm not sure.
- Recognizing a psc node should be done by inspecting the compatible
property, not by device_type and model properties.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
