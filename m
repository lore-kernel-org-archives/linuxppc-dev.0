Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Skiboot] [PATCH 1/2] SLW: Remove stop1_lite and stop0 stop states
In-Reply-To: <87lgd13vjo.fsf@linux.vnet.ibm.com>
References: <1525079529-2284-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20180501134723.5d00ddf0@roar.ozlabs.ibm.com>
 <20180503090647.xsfw3p7mq2pwd2rw@aksadiga.ibm>
 <20180503192852.13a42712@roar.ozlabs.ibm.com>
 <87lgd13vjo.fsf@linux.vnet.ibm.com>
Date: Fri, 04 May 2018 11:02:38 +1000
Message-ID: <877eok9qs1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stewart Smith <stewart@linux.vnet.ibm.com> writes:
...
>
> Slightly stupid question: should we be disabling these here or should
> Linux be better and deciding what states to use?
>
> I'm inclined to say this is a Linux problem as it should make the
> decision of what hardware feature to used based on the ones OPAL says
> *can* be used.

Yeah I agree.

Firmware shouldn't be implementing the policy around what states to use,
it should tell the operating system (which might be Linux) what states
are available and what their features are.

The exception to that would be that we have unfixable crash bugs in
existing kernels, in that case firmware might have to filter out states
that are known to cause those.

cheers
