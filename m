Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 111CF14010D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:39:23 +1000 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 10:39:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 651C0219005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 10:39:09 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T9dHK253018854
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 09:39:17 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T9dF15021233
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 03:39:16 -0600
Message-ID: <535F7319.8030201@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 11:38:33 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [git pull] Please pull abiv2 branch
References: <20140423124902.5be9dab0@kryten>
 <535E6804.5050508@linux.vnet.ibm.com> <877g69t1my.fsf@rustcorp.com.au>
In-Reply-To: <877g69t1my.fsf@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: philippe.bergheaud@fr.ibm.com, mikey@neuling.org, amodra@gmail.com,
 rostedt@goodmis.org, ulrich.weigand@de.ibm.com, mjw@linux.vnet.ibm.com,
 Anton Blanchard <anton@samba.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rusty Russell wrote:
> Philippe Bergheaud <felix@linux.vnet.ibm.com> writes:
> 
>>Anton Blanchard wrote:
>>
>>>Here are the ABIv2 patches rebased against 3.15-rc2.
>>
>>After recompiling 3.15-rc2 with the ABIv2 patches,
>>I see the following line in Modules.symvers:
>>
>>     0x00000000 TOC. vmlinux EXPORT_SYMBOL
>>
>>Kernel will not load modules because TOC. has no CRC.
>>Is this expected ? Shouldn't TOC. have a CRC ?
> 
> 
> What happens when you try to load a module?  It should work...

My mistake, sorry: kernel 3.15-rc2 crashes at boot, in the SLES12
Beta5 environment that I am using, before any module load attempt.

The problem happens with the SLES12 kernel of the day 3.12.17,
plus the backported ABIv2 patch set.  Boot fails with:
     kernel: ibmveth: no symbol version for TOC.
     kernel: ibmveth: Unknown symbol TOC. (err -22)
     kernel: scsi_mod: no symbol version for TOC.
     kernel: scsi_mod: Unknown symbol TOC. (err -22)

In the rescue shell, repeating a plain modprobe fails again:
     :/# modprobe scsi_mod
     modprobe: ERROR: could not insert 'scsi_mod': Invalid argument

And finally, modprobe succeeds with --force:
     :/# modprobe --force scsi_mod
     scsi_mod: module has bad taint, not creating trace events

Philippe
