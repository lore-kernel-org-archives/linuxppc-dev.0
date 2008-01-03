Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id CE1A0DDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 04:27:26 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1143434anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jan 2008 09:27:25 -0800 (PST)
Message-ID: <fa686aa40801030927l4dc95a63s9670d6f6deb3a8c5@mail.gmail.com>
Date: Thu, 3 Jan 2008 10:27:24 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: mojtaba <kernelppc@gmail.com>
Subject: Re: File system problem
In-Reply-To: <004801c84e21$59312760$0b937620$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0801021932s6671526dve15d1948da52ae30@mail.gmail.com>
	<004801c84e21$59312760$0b937620$@com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/3/08, mojtaba <kernelppc@gmail.com> wrote:
> Hi,
> Thank you very much for your answers.
>
> But I have both console and null in /dev.
>
> -rw-rw-rw- 1 mojtaba mojtaba    0 2007-12-26 15:50 console
> -rw-rw-rw- 1 mojtaba mojtaba    0 2007-12-26 15:50 null
>
> They have been created by buildroot. Do I need to create them manually?
> Actually the size of both of them is 0 and both are empty files. Is that a
> problem?

They should look like this:

crw------- 1 root root 5, 1 2008-01-03 07:43 /dev/console
crw-rw-rw- 1 root root 1, 3 2007-10-08 18:39 /dev/null

They are not regular files.  They are device files created with the
'mknod' command.

Instead of a size, these files have 2 number; the device major and
minor numbers.  /dev/console uses major 5, minor 1.  /dev/null is
major 1 minor 3.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
