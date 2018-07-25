Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bQTp2SQvzF09c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 05:37:01 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PJY1nM039999
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 15:36:58 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kewgk4usm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 15:36:57 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 25 Jul 2018 13:36:57 -0600
Date: Wed, 25 Jul 2018 16:36:47 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linux-kernel@vger.kernel.org, "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/7] powerpc: Modernize unhandled signals message
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
Message-Id: <20180725193647.GA23643@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Mikey.

On Wed, Jul 25, 2018 at 05:00:21PM +1000, Michael Neuling wrote:
>  On Tue, 2018-07-24 at 16:27 -0300, Murilo Opsfelder Araujo wrote:
> > Hi, everyone.
> > 
> > This series was inspired by the need to modernize and display more
> > informative messages about unhandled signals.
> > 
> > The "unhandled signal NN" is not very informative.  We thought it would
> > be helpful adding a human-readable message describing what the signal
> > number means, printing the VMA address, and dumping the instructions.
> > 
> > We can add more informative messages, like informing what each code of a
> > SIGSEGV signal means.  We are open to suggestions.
> > 
> > I have collected some early feedback from Michael Ellerman about this
> > series and would love to hear more feedback from you all.
> 
> Nice.. the instruction dump would have been very handy when debugging the PCR
> init issue I had a month or so back.
> 
> > Before this series:
> > 
> >     Jul 24 13:01:07 localhost kernel: pandafault[5989]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00003fff85a75100 code 2
> > 
> > After this series:
> > 
> >     Jul 24 13:08:01 localhost kernel: pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
> >     Jul 24 13:08:01 localhost kernel: Instruction dump:
> >     Jul 24 13:08:01 localhost kernel: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
> >     Jul 24 13:08:01 localhost kernel: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> 
> What happens if we get a sudden flood of these from different processes that
> overlap their output? Are we going to be able to match up the process with
> instruction dump?

As to the flood of messages, ___ratelimit() makes me think that we'll
likely see some warn messages informing how many show_signal_msg()
callbacks were suppressed, instead of interleaved messages and
instruction dumps.

As to matching process with instruction dump, I believe we'd need more
information to glue them together.

What if we modify show_instructions() to accept a string prefix to be
printed along with each line?

> Should we prefix every line with the PID to avoid this?

That's possible.  An alternative would be prefixing each line with the
process name and its PID, as in the first line.  For example:

    pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
    pandafault[10758]: Instruction dump:
    pandafault[10758]: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
    pandafault[10758]: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

The above can be interleaved with other messages and we'll still be able
to match process and its corresponding instruction dump.

Cheers
Murilo
