Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 5302DDDF65
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 02:34:25 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so450509anc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Dec 2007 07:34:24 -0800 (PST)
Message-ID: <fa686aa40712110734v7b83b9e1lef9f59701ff98ad3@mail.gmail.com>
Date: Tue, 11 Dec 2007 08:34:23 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: greenlean <jmgomez@atc.ugr.es>
Subject: Re: Linux 2.6 from git.xilinx and XUPV2P
In-Reply-To: <14274035.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <14274035.post@talk.nabble.com>
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

On 12/11/07, greenlean <jmgomez@atc.ugr.es> wrote:
>
> Hi all,
>
>  I'm a beginner in Xilinx & Linux world and I'm getting a bit loose. I'm
> trying to run linux kernel 2.6 that I downloaded from the xilinx git server
> on the PPC405 of the Xilinx university program Virtex II Pro (XUPV2P for the
> search engine)  board, and I'm using the compiler ELDK 4.1 (I' ve just read
> this compiler may cause some error so I'll change it, and try the 4.0
> version) and I'm getting a lot of compilation error  and warning.

Hmm.  I use ELDK 4.1 daily and I've not had any problems on the
virtex.  What compile errors are you getting?

> I think this is what I should use, Does anybody if I have to patch this
> kernel or if it is still prepatched??

The xilinx git tree should be ready to go without patches.  In fact,
the mainline Linux tree supports the Virtex powerpc.  All that is
missing is some of the device drivers (EMAC, TEMAC).

> My compiler can find some definitions like TASK_SIZE or CONFIG_KERNEL_START,
> now I'm solving it writting  the values manually , I google for the error
> and make the definition where it's needed, but I don't think this is a good
> idea ;). I think this definitions should be defined in the .config file,
> because I found the values I wrote on a posted message in this list.

You should *not* need to do this.  The following should compile a
working kernel for the ml300 reference design (using ELDK):

$ export ARCH=ppc
$ export CROSS_COMPILE=ppc_4xx-
$ make ml300_defconfig
$ make

>
> Maybe somebody could guide me a bit through this kernel compilation, or send
> me .config file running. I don't know if a revision in the project is a good
> way, to put things in situation for beginers.

hint: look in arch/ppc/configs for working .config files.

>
> Thanks, any info would be interesting.

I've collected some of my notes here:
http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex

Hope this helps,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
