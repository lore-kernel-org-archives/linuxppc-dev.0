Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E4911DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 07:48:50 +1100 (EST)
Message-ID: <4741F617.9080408@ovro.caltech.edu>
Date: Mon, 19 Nov 2007 12:46:15 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: Problem with 64-bit variables on ppc405
References: <13844837.post@talk.nabble.com>
In-Reply-To: <13844837.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Mirek,

> Doubles and long long are 8 bytes long but the byte order differs
> on my host linux Intel PC from this what I have on the target
> linux ppc 405.

That would be due to the difference in endianness of the
processors.

http://en.wikipedia.org/wiki/Endianness

If you want to work on data on both an Intel machine, and a
PowerPC, then you have to transfer the data between the machines
using a machine-independent binary format.

There are several around:

1. Network byte order = big-endian.

2. XDR

    http://en.wikipedia.org/wiki/External_Data_Representation

    used by NFS,

3. Common Data Representation

    http://en.wikipedia.org/wiki/Common_Data_Representation

    Which is implemented in the ACE C++ library.

    The nice thing about CDR is that the 'reader makes right',
    so its only when the endianness of the reader is different
    that it has to use CPU cycles to reformat the data.


Its not only processors that have subtle endian issues.
I use little-endian x86 host CPUs in a little-endian PCI
backplane talking to big-endian PowerPC processors.

Data transferred between the processors is first encoded
into a CDR data stream and then decoded. I write binary
data files using the same stream formatters, and then
use mex routines written in C++ to pull the data into
MATLAB data structures.

MATLAB data files are also an example of a machine independent
binary format. But I don't use them.

Cheers,
Dave
