Return-Path: <timur@tabi.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 744D72C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 23:31:12 +1100 (EST)
Message-ID: <510D070D.9060401@tabi.org>
Date: Sat, 02 Feb 2013 06:31:09 -0600
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/512x: add function for CS parameter configuration
References: <1359725305-23916-1-git-send-email-agust@denx.de>
 <CAOZdJXUfe5KWBtabUUPrGHhcFb6dbnPNJCsU23yoxb-4GeKQsg@mail.gmail.com>
 <20130202130201.204ee2fd@crub>
In-Reply-To: <20130202130201.204ee2fd@crub>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij Gustschin wrote:

>>> +struct mpc512x_lpc {
>>> +       u32     cs_cfg[8];      /* CS config */
>>> +       u32     cs_ctrl;        /* CS Control Register */
>>> +       u32     cs_status;      /* CS Status Register */
>>> +       u32     burst_ctrl;     /* CS Burst Control Register */
>>> +       u32     deadcycle_ctrl; /* CS Deadcycle Control Register */
>>> +       u32     holdcycle_ctrl; /* CS Holdcycle Control Register */
>>> +       u32     alt;            /* Address Latch Timing Register */
>>> +};
>>
>> These should be __be32.
>
> Why? To add a new bunch of sparse warnings?

Hmm... I thought that making them __be32 will *avoid* sparse warnings.

>> You forgot the iounmap() if lpc == NULL.
>
> No, it is intentional, no need to map/unmap again and again for all
> subsequent calls.

Sorry, for some reason I thought that lpc was a parameter that you passed in.

-- 
Timur Tabi
