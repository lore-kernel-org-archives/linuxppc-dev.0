Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C56E1A0EFA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2015 02:35:40 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B54DA1401CB
 for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2015 02:35:39 +1000 (AEST)
Date: Fri, 19 Jun 2015 18:35:32 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF] disk-label: add support for booting from GPT FAT
 partition
Message-ID: <20150619183532.762ec775@thh440s>
In-Reply-To: <874mm5edpu.fsf@linux.vnet.ibm.com>
References: <1434017929-1792-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150617122248.77211775@thh440s>
 <874mm5edpu.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 18 Jun 2015 11:54:13 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> Thomas Huth <thuth@redhat.com> writes:
> 
> > On Thu, 11 Jun 2015 15:48:49 +0530
> > Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
> >
> >> +   block-size * to seek-pos
> >> +   block gpt>part-entry-size l@-le to gpt-part-size
> >> +   block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
> >> +   1+ 1 ?DO
> >> +      seek-pos 0 seek drop
> >> +      block gpt-part-size read drop
> >
> > Can you be sure that gpt-part-size is only smaller than 4096 bytes
> > here? 
> 
> So the size is usually 128, so this should be fine.
> 
> https://en.wikipedia.org/wiki/GUID_Partition_Table
> 
> Section: GPT header format
> 
> "84 (0x54)	4 bytes	Size of a single partition entry (usually 128)"

Ok, so it should be fine when you have a valid GPT ... however, one
thing I learnt during my past years: Never ever blindly trust data that
you get from an external medium ... it could have been corrupted by
accident or on purpose. So if you want to make your code more robust,
maybe better check gpt>part-entry-size for being in the range of d# 128
to d# 4096 or you might have to debug very strange crashes one day...

 Thomas
